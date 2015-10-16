
<!-- //////////// in ////////////////// -->

    <?php
        /**
         * module gallery schwarz-weiss.net
         * @author: jw
         *
         * in     
         */ 
    ?>
    <h4>Bitte Bilder auswählen</h4>
    <div class="entry-wrapper">
        <p>REX_MEDIALIST_BUTTON[1]</p>
    </div>

    <div class="entry-wrapper">
        <p><input type="checkbox" name="VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt</p> 
        <p><input type="checkbox" name="VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt (light gray)</p> 
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
        
        # will we start a new division?   
        if(REX_IS_VALUE[2]) {
    ?>
        </div>
    </div>
    <div class="gallery-division">
        <div class="gallery-inner">
    <?php
        };
        
        # will we start a new gray division
        if(REX_IS_VALUE[3]) {
    ?>
        </div>
    </div>
    <div class="gallery-division gallery-division-gray">
        <div class="gallery-inner">
    <?php
        }; 
        
        
        # get list of images
        $gfx_string = "REX_MEDIALIST[1]";
            if($gfx_string != ''):
    ?> 

        <div class="gallery-thumblist-wrapper"> 
            <ul class="gallery-thumblist"> 
                <?php
                    $gfxlist =  explode(',',$gfx_string);             
                
                    foreach ($gfxlist as $gfx) { 
                
                        # create key from image's name
                        $key =  substr($gfx, 0, strpos($gfx, '.'));
                
                        if ($file = OOMedia::getMediaByFileName($gfx)) {

                            $gfxdata[$key] =  Array(
                                'title' => $file->getValue("med_title_" . $REX["CUR_CLANG"]),
                                'desc'  => $file->getValue("med_description_" . $REX["CUR_CLANG"]),
                                'copy'  => $file->getValue("med_copyright"),
                                'loc'   => $file->getValue("med_location"),
                                'wd'    => $file->getValue("width"),
                                'ht'    => $file->getValue("height"),
                                'gfx'   => $gfx,
                            );
        
                            if ($gfxdata[$key]['ht'] > $gfxdata[$key]['wd']) {
                                $gfxdata[$key]['thumb'] =  'ht_150';
                                $gfxdata[$key]['view']  =  'ht_1000';
                            } else {
                                $gfxdata[$key]['thumb'] =  'wd_150';
                                $gfxdata[$key]['view']  =  'wd_1000';                        
                            }
                            
                            if(OOAddon::isAvailable('seo42')) {
                                $view_url   =  "/imagetypes/" . $gfxdata[$key]['view'] . "/" . $gfx;
                                $thumb_url  =  "/imagetypes/" . $gfxdata[$key]['thumb'] . "/" . $gfx;
                            } else {
                                $view_url   =  "/index.php?rex_img_type=" . $gfxdata[$key]['view'] . "&rex_img_file=" . $gfx;
                                $thumb_url  =  "/index.php?rex_img_type=" . $gfxdata[$key]['thumb'] . "&rex_img_file=" . $gfx;
                            }
                    
                ?> 
                     <li>
                        <div><a rel="<?php echo $view_url ?>" href="<?php echo $_SERVER['REQUEST_URI'] ?>#!<?php echo $key ?>"><span></span><img data-key="<?php echo $key ?>" data-view="<?php echo $view_url ?>" src="<?php echo $thumb_url ?>" alt="<?php echo addslashes($gfxdata[$key]['title']) ?>"></a></div>
                        <div class="gallery-image-description" id="info-<?php echo $key ?>">
                            <h2><?php echo $gfxdata[$key]['title'] ?></h2>
                            <p>
                                <?php 
                                    if(trim($gfxdata[$key]['desc']) !== '') { 
                                        $txt =  preg_replace("#\r#", "", $gfxdata[$key]['desc']); 
                                        echo preg_replace("#\n\s*\n\s*#","</p><p>", $txt); 
                                    } else {
                                ?>
                                    Für das Bild <?php echo $key ?> ist keine Beschreibung vorhanden!
                                <?php
                                    }
                                ?>
                            </p>                        
                        </div>  
                        <script type="application/ld+json">
                        {
                            "@context": "http://schema.org",
                            "@type": "ImageObject",
                            "author": "Joachim Wendenburg",
                            "contentUrl": "<?php echo $view_url ?>",
                            "description": "<?php echo addslashes($gfxdata[$key]['desc']) ?>",
                            <?php if($gfxdata[$key]['loc']) { ?>"contentLocation": "<?php echo $gfxdata[$key]['loc'] ?>",<?php echo "\n"; } ?>
                            "name": "<?php echo addslashes($gfxdata[$key]['title']) ?>"    
                        }
                        </script>                         
                    </li>  
                <?php
                        }
                    } 
                    # endforeach gfxlist

                    # we need this data later again 
                    # since vars are valid within module only
                    # save collected gfxdata as a GLOBAL var
                    #
                    if(!isset($GLOBALS['gfxdata'])) {
                        $GLOBALS['gfxdata'] =  Array();
                    }
                    $GLOBALS['gfxdata'] =  array_merge($GLOBALS['gfxdata'], $gfxdata);
                ?>
            </ul>
        </div>
    <?php endif ?>