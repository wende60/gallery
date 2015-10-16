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

?><body>
    <div id="gallery-wrapper">
        <div id="navi-wrapper">
            <div class="navi-list-wrapper">
                <?php
                    $mainNaviTemplate = new rex_template($main_navi_tpl_id);	
                    include $mainNaviTemplate->getFile();
                ?>
            </div>
        </div> 

        <div id="static-wrapper">
            <div class="gallery-toolbar">
                <p title="Navigation anzeigen" class="gallery-button gallery-navi" onclick="gallery.toggle_navi()"><span>Navigation</span></p>
            </div> 
        
            <div class="gallery-division">
                <div class="gallery-inner">
                    <?php echo $this->getArticle(1)?> 
                </div>
            </div> 
            <?php if($article_id === $formmailer_article_id): ?>  
                <div class="gallery-division gallery-division-form">
                    <div class="gallery-inner">       
                        <?php include $REX["INCLUDE_PATH"] . "/mail.inc.php" ?>                       
                        <div class="gallery-contactform">
                            <?php 
                                # ---------------------------
                                # uuups?
                                # ---------------------------
                                #
                                if ($mail_error): 
                            ?>
                                <p class="error"><?=$mail_error?></p>
                            <?php endif ?>
                            <?php
                                # ---------------------------
                                # feddich?
                                # ---------------------------
                                #
                                if ($complete):        
                            ?>    
                                <p class="message">###confirm###</p>                    
                            <?php
                                # ---------------------------
                                # nich feddich?
                                # ---------------------------
                                #
                                else:
                            ?>
                                <form action="<?php echo rex_getUrl($this->getValue("article_id"), $language_id); ?>" method="post" name="mailform">                 
                                    <p>
                                        <label>###firstname###</label>
                                        <input type="text" name="firstname" value="<?=$firstname?>">
                                    </p>
                                    <p>
                                        <label>###lastname###</label>	
                                        <input type="text" name="lastname" value="<?=$lastname?>" >
                                    </p>
                                    <p>
                                        <label>###email###</label>
                                        <input type="text" name="email" value="<?=$email?>">
                                    </p>                  
                                    <p>   
                                        <label>###message###</label>
                                        <input class="customer" type="text" name="customer" value="<?=$customer?>">             
                                        <textarea name="message"><?=$message?></textarea>
                                    </p>
                                    <p class="sender">
                                        <input class="sender" type="submit" value=" ###send### ">
                                        <input type="hidden" name="is_send" value="1">                  
                                    </p>                
                                </form>	
                            <?php
                                # ---------------------------
                                # end feddich!
                                # ---------------------------
                                #
                                endif;
                            ?>                 
                        </div>
                    </div>
                </div>                
            <?php endif?>
            <?php
                $bottom_content =  $this->getArticle(2);
                if($bottom_content) {
            ?>
            <div class="gallery-division">
                <div class="gallery-inner">
                    <?php echo $bottom_content?> 
                </div>
            </div> 
            <?php
                }
                #$bottom_content
            ?>
        </div>
    </div>
    <?php
        $documentFooterTemplate = new rex_template($document_footer_tpl_id);	
        include $documentFooterTemplate->getFile();
    ?>
</body>
</html>