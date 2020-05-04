<?php
$servername = "localhost";
$username = "user_app";
$password = "12345";

try {
    $conn = new PDO("mysql:host=$servername;dbname=db_app", $username, $password,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8") );
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $categories = $conn->prepare("SELECT * FROM Categories");
    $categories->execute();

    $categorie = $_GET['categorie'];

    if($categorie){
        $articles = $conn->prepare("SELECT * FROM Articles WHERE categorie_id =".$categorie);
    } else{
        $articles = $conn->prepare("SELECT * FROM Articles");
    }

  
    $articles->execute();


    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
?>
<!doctype html>

<html lang="fr">
<head>
  <meta charset="utf-8">

  <title>Lamp</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="?categorie=1">Lamp</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
        <?php
        foreach($categories->fetchAll() as $categorie){
        ?>
        <li class="nav-item">
            <a class="nav-link" href="?categorie=<?= $categorie['id'] ?>"><?= $categorie['nom'] ?></a>
        </li>
        <?php } ?>
        </ul>
    </div>
    </nav>
    <div class="container">
<div class="row mt-5">
    <?php
        foreach($articles->fetchAll() as $article){
        ?>
    <div class="col-md -4 mr-2 card">
  <div class="card-body">
    <h5 class="card-title"><?= $article['Titre'] ?></h5>
    <p class="card-text"><?= $article['contenu'] ?></p>
  </div>
</div>
<?php } ?>
</div>
</div>
</body>
</html>