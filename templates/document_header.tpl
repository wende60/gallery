<!DOCTYPE html>REX_TEMPLATE[1]
<html lang="<?php echo $langCode ?>">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes" />
    <meta charset="utf-8" />
    <meta name="author" content="kgde@wendenburg.de">

    <!-- ///////////////////////////////////

    done with redaxo: http://www.redaxo.org
          cool stuff, thank you guys

    //////////////////////////////////// -->
    <?php
          $seo = new rex_yrewrite_seo();
          echo $seo->getTitleTag().PHP_EOL;
          echo $seo->getDescriptionTag().PHP_EOL;
          echo $seo->getRobotsTag().PHP_EOL;
          echo $seo->getHreflangTags().PHP_EOL;
          echo $seo->getCanonicalUrlTag().PHP_EOL;
    ?>
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
</head>
<body>
    <div id="gallery-wrapper">
        <div id="navi-wrapper">
            <div class="navi-list-wrapper">
                REX_TEMPLATE[4]
            </div>
        </div>
