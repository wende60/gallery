
<!-- //////////// in ////////////////// -->

<?php
    /**
     * module textile content text bild schwarz-weiss.net
     * @author: jw
     *
     */
    if (rex_addon::get('markitup')->isAvailable() || rex_addon::get('textile')->isAvailable()) {
?>

    <div class="entry-wrapper">
        <h4>Artikelfoto: </h4>
        REX_MEDIA[id=1 widget=1]
        <?php if(REX_MEDIA[1]) { ?>
            <p><img src="index.php?rex_media_type=wd300&rex_media_file=REX_MEDIA[1]"></p>
        <?php } ?>
    </div>

    <div class="entry-wrapper">
        <h4>Fliesstext: </h4>
        <p><textarea class="markitupEditor-textile_full" name="REX_INPUT_VALUE[1]">REX_VALUE[1]</textarea></p>
    </div>

    <div class="entry-wrapper">
        <p><input type="checkbox" name="REX_INPUT_VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1") { ?>checked="checked"<?php } ?>> Neuer Abschnitt</p>
        <p><input type="checkbox" name="REX_INPUT_VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1") { ?>checked="checked"<?php } ?>> Neuer Abschnitt (light gray)</p>
    </div>

    <div class="entry-wrapper">
        <h4>Link</h4>
        <p><input type="text" name="REX_INPUT_VALUE[4]" value="REX_VALUE[4]"><p>
    </div>

    <div class="entry-wrapper">
        <p><input type="checkbox" name="REX_INPUT_VALUE[5]" value="1" <?php if("REX_VALUE[5]" === "1") { ?>checked="checked"<?php } ?>> Bild weiss unterlegt</p>
    </div>

<?php
    } else {
        echo rex_view::warning('Dieses Modul benötigt das "markitup oder textile" Addon!');
    }
?>

<!-- //////////// out ///////////////// -->

<?php
    if (rex_addon::get('markitup')->isAvailable() || rex_addon::get('textile')->isAvailable()) {

        $column1 = 'REX_VALUE[1]' ? KgdeHelper::returnTextile('REX_VALUE[1]') : false;
        $imageLink  = 'REX_VALUE[4]' ? REX_VALUE[4] : false;

        if ($column1 || REX_MEDIA[1]) {

            # will we start a new division
            if(REX_VALUE[2] || REX_VALUE[3]) {
                $add_class =  "";
                if(REX_VALUE[3]) {
                    $add_class =  "gallery-division-gray";
                } ?>

                    </div>
                </div>
                <div class="gallery-division <?php echo $add_class ?>">
                    <div class="gallery-inner">

                <?php } #REX_VALUE[2] || REX_VALUE[3]
            ?>

            <div class="content-text-image">
                <?php
                    if ("REX_MEDIA[1]" !== '') {
                        $mediaData = rex_media::get("REX_MEDIA[1]");
                        $imageTitle = $mediaData->getValue('med_title_' . 'REX_CLANG_ID');
                        $imageType = "wd300";

                        if (rex_addon::get('yrewrite')->isAvailable()) {
                            $imageSrc =  '/imagetypes/' . $imageType . '/REX_MEDIA[1]';
                        } else {
                            $imageSrc = 'index.php?rex_media_type=' . $imageType . '&rex_media_file=' . 'REX_MEDIA[1]';
                        }

                        $classImageWrapper = "";
                        if(REX_VALUE[5]) {
                            $classImageWrapper = "image-wrapper-light";
                        } ?>

                            <div class="image-wrapper <?php echo $classImageWrapper ?>">
                                <?php if ($imageLink) { ?>
                                    <a title="<?php echo $imageTitle; ?>" href="<?php echo $imageLink; ?>">
                                <?php } ?>

                                <img title="<?php echo $imageTitle; ?>" src="<?php echo $imageSrc; ?>" alt="<?php echo $imageTitle; ?>">

                                <?php if ($imageLink) { ?>
                                    </a>
                                <?php } ?>

                                <p><?php echo $imageTitle?></p>
                            </div>

                        <?php
                    } #REX_MEDIA[1]

                    if ($column1) { ?>
                        <div class="text-wrapper"><?php echo $column1 ?></div>
                    <?php }
                ?>
            </div>
        <?php } #$column1 || REX_MEDIA[1]

    } else {
        echo rex_view::warning('Dieses Modul benötigt das "markitup oder textile" Addon!');
    }
?>


















