REX_TEMPLATE[2]

    <?php

        $articleGalleryContent = $this->getArticle(1);
        $gfxdata = rex::getProperty('gfxdata');
        $escapedFragment = false;
        $fragmentImgData = false;
        if (
            isset($_REQUEST['_escaped_fragment_']) &&
            preg_match('#^[\-\_\|\/a-z0-9]+$#i', $_REQUEST['_escaped_fragment_']) &&
            isset($gfxdata[$_REQUEST['_escaped_fragment_']])
        ) {
            $escapedFragment = $_REQUEST['_escaped_fragment_'];
            $fragmentImgData = $gfxdata[$escapedFragment];
        }

        if ($fragmentImgData) {
            if (rex_addon::get('yrewrite')->isAvailable()) {
                $fullSrc = "/imagetypes/" . $fragmentImgData['fullsrc'] . "/" . $fragmentImgData['gfx'];
            } else {
                $fullSrc = "/index.php?rex_img_type=" . $fragmentImgData['fullsrc'] . "&rex_img_file=" . $fragmentImgData['gfx'];
            }
        }
    ?>
    <script type="text/javascript">
        var escaped_fragment = <?php if ($escapedFragment) { ?>'<?php echo $escapedFragment ?>'<?php } else { ?>false<?php } ?>;
    </script>

    <div id="thumblist-wrapper" class="thumblist-wrapper">
        REX_TEMPLATE[9]

        <div class="gallery-division">
            <div class="gallery-inner">
                <?php echo $articleGalleryContent ?>
            </div>
        </div>

        REX_TEMPLATE[8]

    </div>
    <div id="viewimage-wrapper" class="viewimage-wrapper">
        <div id="image-tools" class="gallery-toolbar">
            <p title="Vorheriges Bild anzeigen"                     class="gallery-button gallery-prev" onclick="gallery.dpl_first_view()"><span>Prev</span></p>
            <p title="Zurück zur Übersicht"                         class="gallery-button gallery-thumb" onclick="gallery.dpl_thumb_list()"><span>Thumblist</span></p>
            <p title="Beschreibung anzeigen"                        class="gallery-button gallery-info" onclick="gallery.display_info()"><span>Info</span></p>
            <p title="Bild direkt anzeigen (zoomen, speichern)"     class="gallery-button gallery-imgsrc" onclick="gallery.dpl_image_src()"><span>Image</span></p>
            <p title="Nächstes Bild anzeigen"                       class="gallery-button gallery-next" onclick="gallery.dpl_last_view()"><span>Next</span></p>
        </div>
        <ul id="viewimage-wrapper-list">
            <li>
                <span></span>
                <img id="gallery-view-img-1" alt="" src="gfx/loader.gif">
            </li>
            <li>
                <span></span>
                <?php if ($fragmentImgData) { ?>
                    <img id="gallery-view-img-2" alt="<?php echo addslashes($fragmentImgData['title']) ?>" src="<?php echo $fullSrc ?>">
                    <script type="application/ld+json">
                    {
                        "@context": "http://schema.org",
                        "@type": "ImageObject",
                        "author": "Joachim Wendenburg",
                        "contentUrl": "<?php echo $fullSrc ?>",
                        "description": "<?php echo addslashes($fragmentImgData['desc']) ?>",
                        <?php if($fragmentImgData['loc']) { ?>
                        "contentLocation": "<?php echo $fragmentImgData['loc'] ?>",
                        <?php } ?>
                        "name": "<?php echo addslashes($fragmentImgData['title']) ?>"
                    }
                    </script>
                <?php } else { ?>
                    <img id="gallery-view-img-2" alt="" src="gfx/loader.gif">
                <?php } ?>
            </li>
            <li>
                <span></span>
                <img id="gallery-view-img-3" alt="" src="gfx/loader.gif">
            </li>
        </ul>
        <div class="image-info-wrapper">
            <div id="image-info">
                <?php if($fragmentImgData) { ?>
                    <h2><?php echo $fragmentImgData['title'] ?></h2>
                    <p>
                        <?php
                            if(trim($fragmentImgData['desc']) !== '') {
                                $txt =  preg_replace("#\r#", "", $fragmentImgData['desc']);
                                echo preg_replace("#\n\s*\n\s*#","</p><p>", $txt);
                            }
                        ?>
                    </p>
                <?php } ?>
            </div>
            <div class="image-info-additionals">
                <p title="Bild direkt anzeigen (zoomen, speichern)" onclick="gallery.dpl_image_src()">Bild direkt anzeigen (zoomen, speichern).</p>
            </div>
        </div>
    </div>

REX_TEMPLATE[3]
