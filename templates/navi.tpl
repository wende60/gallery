<ul>
    <?php

        /**
         * template schwarz-weiss navigation
         * displays categories and it's articles
         * @author: jw
         *
         */

        $className  = '';
        foreach (rex_category::getRootCategories() as $rootCategory) {
            if ($rootCategory->isOnline(true)) {
                if ($rootCategory->getId() == $categoryId) {
                    $className = 'navi-top-sel';
                } else {
                    $className = 'navi-top-norm';
                }

                // get meta field
                $classIsGallery = $rootCategory->getValue('cat_is_gallery');
                ?>
                    <li class="<?php echo $className; ?> <?php echo $classIsGallery ?>">
                        <a href="<?php echo $rootCategory->getUrl(); ?>">
                            <?php echo htmlspecialchars($rootCategory->getValue('name')); ?>
                        </a>
                    </li>
                <?php
            }
        }
    ?>
</ul>

