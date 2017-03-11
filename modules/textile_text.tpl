
<!-- //////////// in ////////////////// -->

<?php
    /**
     * module textile content text schwarz-weiss.net
     * @author: jw
     *
     * in
     */
    if (rex_addon::get('markitup')->isAvailable() || rex_addon::get('textile')->isAvailable()) {
?>

    <div class="entry-wrapper">
        <h4>Fliesstext:</h4>
        <p><textarea class="markitupEditor-textile_full" name="REX_INPUT_VALUE[1]">REX_VALUE[1]</textarea></p>
    </div>

    <div class="entry-wrapper">
        <p><input type="checkbox" name="REX_INPUT_VALUE[2]" value="1" <?php if("REX_VALUE[2]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt</p>
        <p><input type="checkbox" name="REX_INPUT_VALUE[3]" value="1" <?php if("REX_VALUE[3]" === "1"): ?>checked="checked"<?php endif ?>> Neuer Abschnitt (light gray)</p>
    </div>

<?php
    } else {
        echo rex_view::warning('Dieses Modul benötigt das "markitup oder textile" Addon!');
    }
?>


<!-- //////////// out ///////////////// -->


<?php
    if (rex_addon::get('markitup')->isAvailable() || rex_addon::get('textile')->isAvailable()) {
        $column1 = 'REX_VALUE[1]' ? KgdeHelper::returnTextile('REX_VALUE[1]') : false;
        if ($column1) {

        # will we start a new division
        if(REX_VALUE[2] || REX_VALUE[3]) {
            $add_class =  "";
            if(REX_IS_VALUE[3]) {
                $add_class =  "gallery-division-gray";
            }
        ?>
            </div>
        </div>

        <div class="gallery-division <?php echo $add_class ?>">
            <div class="gallery-inner">
        <?php } #REX_IS_VALUE[2] || REX_IS_VALUE[3] ?>

            <div class="content-text"><?php echo $column1 ?></div>

        <?php
        }
    } else {
        echo rex_view::warning('Dieses Modul benötigt das "markitup oder textile" Addon!');
    }
?>
