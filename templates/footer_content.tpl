
    <div id="footer">
        <div class="gallery-inner">
            <div class="column-wrapper">
                <div class="footerLeft">
                    <?php
                        $footerContent = new rex_article_content;
                        $footerContent->setArticleID($footerArticleId);
                        echo $footerContent->getArticle(1);
                    ?>
                </div>
                <div class="footerRight">
                    <?php
                        echo $footerContent->getArticle(2);
                    ?>
                </div>
            </div>
            <div class="footerFull">
                <p>© <?php echo date('Y') ?> Joachim Wendenburg</p>
            </div>
        </div>
    </div>