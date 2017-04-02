
<div class="topbar">
    <div id="hamburgerMenu" title="Navigation anzeigen" class="hamburger-menu" onclick="gallery.toggle_navi()">
        <div>
            <span class="hamburgerTop"></span>
            <span class="hamburgerMed"></span>
            <span class="hamburgerBot"></span>
        </div>
    </div>
    <?php
        $startUrl = rex_category::get(1)->getUrl();
    ?>
    <a href="<?php echo $startUrl ?>" class="topbar-text">schwarz-weiss.net</a>
</div>