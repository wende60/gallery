REX_TEMPLATE[2]

    <div id="static-wrapper">
        REX_TEMPLATE[9]

        <div class="gallery-division">
            <div class="gallery-inner">
                <?php echo $this->getArticle(1)?>
            </div>
        </div>

        <?php if(REX_ARTICLE_ID === $formmailerArticleId) { ?>

            <div class="gallery-division gallery-division-form">
                <div class="gallery-inner">
                    <?php
                        $formmailer = new kgdeMail($formmailerEmailFrom, $formmailerEmailTo);
                        $mailState  = $formmailer->getMailState();
                    ?>
                    <div class="gallery-contactform">
                        <?php if ($mailState !== 'inital') { ?>
                            <div class="messageContainer">
                                <?php
                                    # ---------------------------
                                    # error?
                                    # ---------------------------
                                    if ($mailState === 'error') {
                                ?>
                                    <p class="error">
                                        ###mailerror###<br>
                                        <?php echo $formmailer->getError('<br>') ?>
                                    </p>
                                <?php } ?>
                                <?php
                                    # ---------------------------
                                    # fish?
                                    # ---------------------------
                                    if ($mailState === 'fish') {
                                ?>
                                    <p class="message">###fish###</p>
                                <?php } ?>
                                <?php
                                    # ---------------------------
                                    # feddich?
                                    # ---------------------------
                                    if ($mailState === 'send') {
                                ?>
                                    <p class="message">###confirm###</p>
                                <?php } ?>
                            </div>
                        <?php } #mailState ?>

                        <?php if ($mailState === 'inital' || $mailState === 'error') { ?>
                            <div class="kgde-contactform">
                                <form action="<?php echo rex_getUrl(REX_ARTICLE_ID,REX_CLANG_ID) ?>" method="post" name="mailform">
                                    <p>
                                        <label>###firstname###</label>
                                        <input type="text" name="firstname" value="<?php echo $formmailer->getSentValue('firstname'); ?>">
                                    </p>
                                    <p>
                                        <label>###lastname###</label>
                                        <input type="text" name="lastname" value="<?php echo $formmailer->getSentValue('lastname'); ?>" >
                                    </p>
                                    <p>
                                        <label>###email###</label>
                                        <input type="text" name="email" value="<?php echo $formmailer->getSentValue('email'); ?>">
                                    </p>
                                    <p>
                                        <label>###message###</label>
                                        <input class="customer" type="text" name="customer" value="<?php echo $customer; ?>">
                                        <textarea name="message"><?php echo $formmailer->getSentValue('message'); ?></textarea>
                                    </p>
                                    <p class="sender">
                                        <input class="sender" type="submit" value=" ###send### ">
                                        <input type="hidden" name="is_send" value="1">
                                    </p>
                                </form>
                            </div>
                        <?php } # nich feddich ?>
                    </div>
                </div>
            </div>
        <?php } #formmailerArticleId ?>

        <?php
            $articleBottomContent = $this->getArticle(2);
            if($articleBottomContent) {
        ?>
            <div class="gallery-division">
                <div class="gallery-inner">
                    <?php echo $articleBottomContent?>
                </div>
            </div>
        <?php } ?>

        REX_TEMPLATE[8]

    </div>

REX_TEMPLATE[3]
