
<!-- //////////// in ////////////////// -->

<?php
    /**
     * module textile content text schwarz-weiss.net
     * @author: jw
     *
     */
    if (rex_addon::get('markitup')->isAvailable() || rex_addon::get('textile')->isAvailable()) {
?>

    <div class="entry-wrapper">
        <h4>Fliesstext:</h4>
        <p><textarea class="markitupEditor-textile_full" name="REX_INPUT_VALUE[1]">REX_VALUE[1]</textarea></p>
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
        ?>

            <div class="content-text"><?php echo $column1 ?></div>

        <?php } #$column1

    } else {
        echo rex_view::warning('Dieses Modul benötigt das "markitup oder textile" Addon!');
    }
?>
