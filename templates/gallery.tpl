<?php

    /**
     * template schwarz-weiss gallery
     * @author: jw
     *
     */
    error_reporting(E_ALL);     
     
    $configTemplate = new rex_template(1);	
    include $configTemplate->getFile();     
     
    $documentHeaderTemplate = new rex_template($document_header_tpl_id);	
    include $documentHeaderTemplate->getFile();
    
    $gallery_content_1  =  $this->getArticle(1);
    
    $_escaped_fragment_ =  false;
    if(
        isset($_REQUEST['_escaped_fragment_']) && 
        preg_match('#^[\-\_\|\/a-z0-9]+$#i', $_REQUEST['_escaped_fragment_']) &&
        isset($GLOBALS['gfxdata'][ $_REQUEST['_escaped_fragment_'] ])
    ) {
        $_escaped_fragment_ =  $_REQUEST['_escaped_fragment_']; 
        $fragment_img_data  =  $GLOBALS['gfxdata'][$_escaped_fragment_];
    }
    
    if(OOAddon::isAvailable('seo42')) {
        $view_url   =  "/imagetypes/" . $fragment_img_data['view'] . "/" . $fragment_img_data['gfx'];
    } else {
        $view_url   =  "/index.php?rex_img_type=" . $fragment_img_data['view'] . "&rex_img_file=" . $fragment_img_data['gfx'];
    }    

?><body>
    <script type="text/javascript">
        var escaped_fragment = <?php if($_escaped_fragment_) { ?>'<?php echo $_escaped_fragment_ ?>'<?php } else { ?>false<?php } ?>;
    </script>
    <div id="gallery-wrapper">
        <div id="navi-wrapper">
            <div class="navi-list-wrapper">
                <?php
                    $mainNaviTemplate = new rex_template($main_navi_tpl_id);	
                    include $mainNaviTemplate->getFile();
                ?>
            </div>
        </div> 
        
        <div id="thumblist-wrapper" class="thumblist-wrapper">
            <div class="gallery-toolbar">
                <p title="Navigation anzeigen" class="gallery-button gallery-navi" onclick="gallery.toggle_navi()"><span>Navigation</span></p>
            </div> 
        
            <div class="gallery-division">
                <div class="gallery-inner">
                    <?php echo $gallery_content_1 ?>   
                </div>
            </div>                    
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
                    <?php if($_escaped_fragment_) { ?>
                        <img id="gallery-view-img-2" alt="<?php echo addslashes($fragment_img_data['title']) ?>" src="<?php echo $view_url ?>">   
                        <script type="application/ld+json">
                        {
                            "@context": "http://schema.org",
                            "@type": "ImageObject",
                            "author": "Joachim Wendenburg",
                            "contentUrl": "<?php echo $view_url ?>",
                            "description": "<?php echo addslashes($fragment_img_data['desc']) ?>",
                            <?php if($fragment_img_data['loc']) { ?>
                            "contentLocation": "<?php echo $fragment_img_data['loc'] ?>",
                            <?php } ?>
                            "name": "<?php echo addslashes($fragment_img_data['title']) ?>"    
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
                    <?php if($_escaped_fragment_) { ?>
                        <h2><?php echo $fragment_img_data['title'] ?></h2>
                        <p>
                            <?php 
                                if(trim($fragment_img_data['desc']) !== '') { 
                                    $txt =  preg_replace("#\r#", "", $fragment_img_data['desc']); 
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
    </div>
    <?php
        $documentFooterTemplate = new rex_template($document_footer_tpl_id);	
        include $documentFooterTemplate->getFile();
    ?>    
</body>
</html>