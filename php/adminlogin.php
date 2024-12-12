<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cool Summer Icecreams</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    

    <header class="header">
        <img src="../images/IcPlogo.jpeg" alt="Logo" class="logo">
        <h1><a href="../index.html"class="header-title">Cool Summer Icecreams</h1></a>
    </header>
    <?php
    $username = "admin";
    $password = "password123";
    $error = "";

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $inputUsername = $_POST['username'];
        $inputPassword = $_POST['password'];

        if ($inputUsername === $username && $inputPassword === $password) {
            header('Location: ../html/payment.html');
            exit;
        } else {
            $error = "Invalid username or password.";
        }
    }
    ?>

<main class="main-content">
<div class="container">

<div class="box2">
        <h2>Login</h2>
        <?php if (!empty($error)): ?>
            <div class="error"> <?php echo $error; ?> </div>
        <?php endif; ?>
        <form method="POST">
            <label for="username">Username</label> 
            <input type="text" id="username" name="username" required><br>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required><br>

            <button class="add-to-cart button-pay" type="submit">Login</button>
        </form>
        </div></div>
    </div>
</body>
</html>
