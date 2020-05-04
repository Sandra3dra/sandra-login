<?php
function login($username, $password, $ip, $reqtime){
    // return sprintf('You are logging in with username=>%s, password=>%s', $username, $password);

    $pdo = Database::getInstance()->getConnection();

    // $hashP = password_hash($password, PASSWORD_DEFAULT);
    // echo $hashP;
    // exit;

    // check existance  SELECT * FROM "tbl_user" WHERE "user_name" =' .$username 'AND "user_pass" =' .$password
    $check_exist_query = 'SELECT COUNT(*) FROM `tbl_user` WHERE user_name =:username';
    $user_set = $pdo->prepare($check_exist_query);
    $user_set->execute(
        array(
            ':username'=>$username
        )
    );

    if($user_set->fetchColumn()>0){
        // check if locked
        $check_if_locked = 'SELECT * FROM `tbl_user` WHERE user_name =:username';
        $user_lock = $pdo->prepare($check_if_locked);
        $user_lock->execute(
            array(
                ':username'=>$username
            )
        );
        while($founduser = $user_lock->fetch(PDO::FETCH_ASSOC)){
            $lock = $founduser['user_locked'];   // the lock col
            $fail_time = $founduser['user_fail_start'];  // when the user was locked
            $hash = $founduser['user_pass']; // pass word from db
            $hashed = substr( $hash, 0, 60 ); // get only the 60 characters from the last value ...password
            $newuser = $founduser['user_new']; // if this is new user
            $createtime = $founduser['user_newstart']; // new user created time
            $newleft = strtotime($reqtime) - strtotime($createtime);
            $newcount = 86400 - $newleft; // new user countdown
            $time_count = strtotime($reqtime) - strtotime($fail_time); // locked count
            $time_left = 300 - $time_count; // locked left time
            $sus = $founduser['user_sus']; // user suspended
            $attempts = $founduser['user_attempts']; // attempts
            $id = $founduser['user_id']; // id
            if($lock === "YES") {
                return '<p>Account locked</p>
                <p>you still have '.$time_left.' seconds until you can try again.</p>';
            } else if($sus === "SUSPENDED") {
                return '<p>Sorry, account suspended due to not logging in 24 housrs after being created.</p>';
            } else if($lock === "NO" || ($lock === "YES" && $time_left <= 0)) {
                if(password_verify($password, $hashed)){
                    $_SESSION['user_id'] = $id;
                    $_SESSION['user_fname'] = $founduser['user_fname'];
                    $_SESSION['user_name'] = $founduser['user_name'];
                    $lastlogin = $founduser['user_currentlogin'];
                    $_SESSION['lastlogin'] = $lastlogin;
                    $newuser = $founduser['user_new'];
                    $update_current_query = 'UPDATE `tbl_user` SET user_currentlogin =:reqtime, user_lastlogin =:lasttime, user_ip =:ip, user_locked =:unlocked, user_fail_start =:emptytime, user_attempts =:zero_attempt WHERE user_id =:id';
                    $current_set = $pdo->prepare($update_current_query);
                    $current_set->execute(
                        array(
                            ':id'=>$id,
                            ':reqtime'=>$reqtime,
                            ':lasttime'=>$lastlogin,
                            ':ip'=>$ip,
                            ':unlocked'=>"NO",
                            ':emptytime'=>$reqtime,
                            ':zero_attempt'=>"0"
                        )
                    );
                    redirect_to('index.php'); 
                } else if(password_verify($password, $hashed) && $newuser === "N"){
                    $_SESSION['user_id'] = $id;
                    $_SESSION['user_fname'] = $founduser['user_fname'];
                    $_SESSION['user_name'] = $founduser['user_name'];
                    $lastlogin = $founduser['user_currentlogin'];
                    $_SESSION['lastlogin'] = $lastlogin;
                    $newuser = $founduser['user_new'];
                    $update_current_query = 'UPDATE `tbl_user` SET user_currentlogin =:reqtime, user_lastlogin =:lasttime, user_ip =:ip, user_locked =:unlocked, user_fail_start =:emptytime, user_attempts =:zero_attempt, user_sus =:nosus WHERE user_id =:id';
                    $current_set = $pdo->prepare($update_current_query);
                    $current_set->execute(
                        array(
                            ':id'=>$id,
                            ':reqtime'=>$reqtime,
                            ':lasttime'=>$lastlogin,
                            ':ip'=>$ip,
                            ':unlocked'=>"NO",
                            ':emptytime'=>$reqtime,
                            ':zero_attempt'=>"0",
                            ':nosus'=>"NO"
                        )
                    );
                    redirect_to('admin_edit_account.php');
                } else if(password_verify($password, $hashed) == false && $attempts < 2) {
                    $more_attempts = $attempts + 1;
                    $left_attempt = 3 - $more_attempts;
                    $update_add_attempt = 'UPDATE `tbl_user` SET user_attempts =:more_attempt WHERE user_id =:id';
                    $add_attempt = $pdo->prepare($update_add_attempt);
                    $add_attempt->execute(
                        array(
                            ':id'=>$id,
                            ':more_attempt'=>$more_attempts
                        )
                    );
                    return '<p>Wrong password, please try agian</p>
                    <p>You have '.$left_attempt.' more attempts left.</p>';
                } else {
                    $update_lock = 'UPDATE `tbl_user` SET user_locked =:locked, user_fail_start =:lockedtime WHERE user_id =:id';
                    $lock_attempt = $pdo->prepare($update_lock);
                    $lock_attempt->execute(
                        array(
                            ':id'=>$id,
                            ':locked'=>"YES",
                            ':lockedtime'=>$reqtime
                        )
                    );
                    return '<p>You have exceeded three attempts. Account locked.</p>
                    <p>you still have '.$time_left.' seconds until you can try again.</p>';
                }
            }
        }
    }else{
        return '<p>User does not exist</p>';
    }
}

function confirm_logged_in() {
    if(!isset($_SESSION['user_id'])){
        redirect_to('admin_login.php');
    }
}

function logout() {
    session_destroy();
    redirect_to('admin_login.php');
}