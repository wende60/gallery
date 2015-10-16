
<!-- //////////// in ////////////////// -->

<?php
    /**
     * module textile text schwarz-weiss.net
     * @author: jw
     *
     * in     
     */ 
    if(OOAddon::isAvailable('textile')) {
?>

    <div class="entry-wrapper">
        <h4>Fliesstext:</h4>
        <p><textarea name="VALUE[1]" cols="150" rows="30" class="txta-full">REX_HTML_VALUE[1]</textarea></p>    
    </div>
    
    <div class="entry-wrapper">
        <p><input type="checkbox" name="VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt</p> 
        <p><input type="checkbox" name="VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt (light gray)</p> 
    </div>     
    
<?php
    // displays help options, mus be activated (user settings)
    rex_a79_help_overview(); 

    } else {
        echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
    }
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

        $textile = '';
        if(REX_IS_VALUE[1]) {
        
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

            echo '<div class="content-text">'. $textile . '</div>';
        }
    } else {
        echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
    }
?>
