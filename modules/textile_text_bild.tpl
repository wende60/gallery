
<!-- //////////// in ////////////////// -->

<?php
    if(OOAddon::isAvailable('textile')):
?>

    <div class="entry-wrapper"> 
        <h4>Artikelfoto</h4>
        REX_MEDIA_BUTTON[1]
        <?php if("REX_FILE[1]" !== ""): ?>
            <div><img src="index.php?rex_img_type=wd300&rex_img_file=REX_FILE[1]"></div>
        <?php endif?>
    </div>
   
    <div class="entry-wrapper">  
        <h4>Fliesstext</h4>
        <p><textarea name="VALUE[1]" cols="80" rows="10" class="inp100">REX_HTML_VALUE[1]</textarea></p>  
    </div>
    
    <div class="entry-wrapper">
        <p><input type="checkbox" name="VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt</p> 
        <p><input type="checkbox" name="VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt (light gray)</p> 
    </div>  
    
    <div class="entry-wrapper">
        <h4>Link</h4>
        <p><input class="inp100" type="text" name="VALUE[4]" value="REX_VALUE[4]"><p>
    </div> 
    
    <div class="entry-wrapper">
        <p><input type="checkbox" name="VALUE[5]" value="1" <?php if("REX_VALUE[5]" === "1"): ?>checked="checked"<?php endif ?>> Bild weiss unterlegt</p> 
    </div>      

<?php
    // displays help options, mus be activated (user settings)
    rex_a79_help_overview(); 
    
    else:
        echo rex_warning('<p>Dieses Modul benötigt das "textile" Addon!</p>');
    endif;
?>

<!-- //////////// out ///////////////// -->

<?php
    if(OOAddon::isAvailable('textile')) {
        # will we start a new division    
        if(REX_IS_VALUE[2] || REX_IS_VALUE[3]) {
            $add_class =  "";
            if(REX_IS_VALUE[3]) {
                $add_class =  "gallery-division-gray";
            }
?>
        </div>
    </div>
    <div class="gallery-division <?php echo $add_class ?>">
        <div class="gallery-inner">
    <?php
        }
        #REX_IS_VALUE[2] || REX_IS_VALUE[3]
    ?>
        <div class="content-text-image">
            <?php 
                if("REX_FILE[1]") { 
                    $file           =  OOMedia::getMediaByFileName("REX_FILE[1]");
                    $gfx_title      =  $file->getValue("med_title_" . $REX["CUR_CLANG"]);                 
                    $gfx_width      =  $file->getValue("width");
                    $gfx_height     =  $file->getValue("height");
                    $image_type     =  "wd300";     
                    
                    $wrap_class =  "";
                    if(REX_IS_VALUE[5]) { 
                        $wrap_class =  "image-wrapper-light";
                    }                    
            ?>
                <div class="image-wrapper <?php echo $wrap_class ?>">
                    <?php 
                        if(REX_IS_VALUE[4]) { 
                            echo '<a href="REX_VALUE[4]">';
                        }
                    ?>
                    <img src="index.php?rex_img_type=<?=$image_type?>&rex_img_file=REX_FILE[1]" title="<?php echo $gfx_title?>" alt="<?php echo $gfx_title?>" />
                    <?php 
                        if(REX_IS_VALUE[4]) {  
                            echo '</a>';
                        }
                    ?>                   
                    <p><?php echo $gfx_title?></p>
                </div>
            <?php 
                }
                #REX_FILE[1] 
                
                if(REX_IS_VALUE[1]) {
                    $textile = '';
                    // allow html, chars must be decoded
                    // replace br-tags
                    // replace leading whitespace after double line-break
                    // textile
                    // wrap in div and p
                    //
                    $textile = htmlspecialchars_decode("REX_VALUE[1]");
                    $textile = str_replace("<br />","",$textile);
                    $textile = preg_replace("#\r#","",$textile); 
                    $textile = preg_replace("#\n\s*\n\s*#","\n\n",$textile); 
                    $textile = preg_replace("#\|\s+\n#","|\n",$textile); // no whitespaces after tailing "|"
                    $textile = rex_a79_textile($textile); 
                
            ?>
                <div class="text-wrapper"><?php echo $textile ?></div>
            <?php
                }
                #REX_IS_VALUE[1]
            ?>
        </div>
<?php   
    } else {
        echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
    }
?>




















