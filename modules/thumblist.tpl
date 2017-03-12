
<!-- //////////// in ////////////////// -->

<?php
    /**
     * module gallery schwarz-weiss.net
     * @author: jw
     *
     */
?>
<div class="entry-wrapper">
    <h4>Bitte Bilder auswählen:</h4>
    REX_MEDIALIST[id=1 widget=1]
</div>

    <div class="entry-wrapper">
        <p><input type="checkbox" name="REX_INPUT_VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1") { ?>checked="checked"<?php } ?>> Neuer Abschnitt</p>
        <p><input type="checkbox" name="REX_INPUT_VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1") { ?>checked="checked"<?php } ?>> Neuer Abschnitt (light gray)</p>
    </div>


<!-- //////////// out ///////////////// -->


<?php
    # attention
    # this uses additional meta entries
    # you can add these entries here:
    #   > AddOns > Meta Infos > Media
    # entries in use:
    # med_title_[language_id]
    # med_descripton_[language_id]
    #
    # will we start a new division
    #
    if(REX_VALUE[2] || REX_VALUE[3]) {
        $add_class =  "";
        if(REX_VALUE[3]) {
            $add_class =  "gallery-division-gray";
        } ?>

            </div>
        </div>
        <div class="gallery-division <?php echo $add_class ?>">
            <div class="gallery-inner">

        <?php
    } #REX_VALUE[2] || REX_VALUE[3]

    # get list of images
    if ('REX_MEDIALIST[1]' !== '') {

    ?>

        <div class="gallery-thumblist-wrapper">
            <ul class="gallery-thumblist">
                <?php
                    $gfxlist = explode(',',REX_MEDIALIST[1]);
                    foreach ($gfxlist as $gfx) {
                        $mediaData = rex_media::get($gfx);

                        # create key from image's name
                        $imageId =  substr($gfx, 0, strpos($gfx, '.'));
                        $gfxdata[$imageId] =  Array(
                            'title' => $mediaData->getValue('med_title_' . 'REX_CLANG_ID'),
                            'desc' => $mediaData->getValue("med_description_" . 'REX_CLANG_ID'),
                            'copy' => $mediaData->getValue("med_copyright"),
                            'loc' => $mediaData->getValue("med_location"),
                            'wd' => $mediaData->getValue("width"),
                            'ht' => $mediaData->getValue("height"),
                            'gfx' => $gfx,
                        );

                        if ($gfxdata[$imageId]['ht'] > $gfxdata[$imageId]['wd']) {
                            $gfxdata[$imageId]['thumbsrc'] = 'ht_150';
                            $gfxdata[$imageId]['lowsrc'] = 'ht_1000';
                            $gfxdata[$imageId]['fullsrc'] = 'ht_2000';
                        } else {
                            $gfxdata[$imageId]['thumbsrc'] = 'wd_150';
                            $gfxdata[$imageId]['lowsrc'] = 'wd_1000';
                            $gfxdata[$imageId]['fullsrc'] = 'wd_2000';
                        }

                        if (rex_addon::get('yrewrite')->isAvailable()) {
                            $lowSrc = '/imagetypes/' . $gfxdata[$imageId]['lowsrc'] . '/' . $gfx;
                            $fullSrc = '/imagetypes/' . $gfxdata[$imageId]['fullsrc'] . '/' . $gfx;
                            $thumbSrc = '/imagetypes/' . $gfxdata[$imageId]['thumbsrc'] . '/' . $gfx;
                        } else {
                            $lowSrc = '/index.php?rex_img_type=' . $gfxdata[$imageId]['lowsrc'] . '&rex_img_file=' . $gfx;
                            $fullSrc = '/index.php?rex_img_type=' . $gfxdata[$imageId]['fullsrc'] . '&rex_img_file=' . $gfx;
                            $thumbSrc = '/index.php?rex_img_type=' . $gfxdata[$imageId]['thumbsrc'] . '&rex_img_file=' . $gfx;
                        }
                    ?>
                        <li>
                            <div><a
                                rel="<?php echo $fullSrc ?>"
                                href="<?php echo rex_getUrl(REX_CATEGORY_ID, REX_CLANG_ID) ?>#!<?php echo $imageId ?>"
                                ><span></span><img
                                    data-key="<?php echo $imageId ?>"
                                    data-lowsrc="<?php echo $lowSrc ?>"
                                    data-fullsrc="<?php echo $fullSrc ?>"
                                    src="<?php echo $thumbSrc ?>"
                                    alt="<?php echo addslashes($gfxdata[$imageId]['title']) ?>"></a></div>
                            <div class="gallery-image-description" id="info-<?php echo $imageId ?>">
                                <h2><?php echo $gfxdata[$imageId]['title'] ?></h2>
                                <p>
                                    <?php
                                        if(trim($gfxdata[$imageId]['desc']) !== '') {
                                            $txt =  preg_replace("#\r#", "", $gfxdata[$imageId]['desc']);
                                            echo preg_replace("#\n\s*\n\s*#","</p><p>", $txt);
                                        } else {
                                    ?>
                                        Für das Bild <?php echo $imageId ?> ist keine Beschreibung vorhanden!
                                    <?php } ?>
                                </p>
                            </div>
                            <script type="application/ld+json">
                            {
                                "@context": "http://schema.org",
                                "@type": "ImageObject",
                                "author": "<?php echo addslashes($gfxdata[$imageId]['copy']) ?>",
                                "contentUrl": "<?php echo $fullSrc ?>",
                                "description": "<?php echo addslashes($gfxdata[$imageId]['desc']) ?>",
                                <?php if($gfxdata[$imageId]['loc']) { ?>"contentLocation": "<?php echo $gfxdata[$imageId]['loc'] ?>",<?php echo "\n"; } ?>
                                "name": "<?php echo addslashes($gfxdata[$imageId]['title']) ?>"
                            }
                            </script>
                        </li>
                    <?php } # endforeach gfxlist

                    # we need this data later again
                    # since vars are valid within module only
                    # save collected gfxdata in rex
                    #
                    $globalGfxData = (null !== rex::getProperty('gfxdata')) ? rex::getProperty('gfxdata') : Array();
                    $globalGfxData = array_merge($globalGfxData, $gfxdata);

                    rex::setProperty('gfxdata', $globalGfxData);
                ?>
            </ul>
        </div>

    <?php } #$gfx_string
?>