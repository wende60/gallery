# gallery

all templates, modules, scripts and css-files for gallery http://www.schwarz-weiss.net/ by Joachim Wendenburg, Munich, Germany
based on CMS Redaxo, http://www.redaxo.org/

**This repository does nor work out of the box. It is thought to give you some inspiration. If you want touse it you have to do some configurations!**

* install redaxo 5x
* install the markitup plugin
* install the sprog plugin for multi-language use

Using the templates you habe to modify the IDs of the included files depending on your setup.
Look for "REX_TEMPLATE[...]" in default.tpl, gallery.tpl and document_header.tpl.
Then edit the config.tpl. Replace the email and edit the $formmailerId. Also edit the footer's article ID in the footer_content.tpl.
Footer is an offline Article using the footer_columns.tpl with 2 columns.

Here's my setup:

ID  | name              | state             | description
--- | ----------------- | ----------------- | ------------
1   | config            | non selectable    | some config (included in document_header)
2   | document_header   | non selectable    | document header and navi
3   | document_footer   | non selectable    | document footer (js-files)
4   | navi              | non selectable    | navi (included in document_header)
9   | topbar            | non selectable    | logo and hamburger menu bar
5   | default           | selectable        | article templates includes 2, 3, 8, 9
6   | gallery           | selectable        | gallery template includes 2, 3, 8, 9
7   | footer_columns    | selectable        | template for footer article only
8   | footer_content    | non selectable    | footer content displays the footer article (should be offline)

You have to create some meta fields. First a select for the categories, in order to display a icon if a category contains a gallery:

* cat_is_gallery: navi-default:Default|navi-gallery:Galerie

Then for the media some inputs and textareas, here for the languages de and en:

* med_title_1 input text title de
* med_title_2  input text title en
* med_description_1 textarea description de
* med_description_2 textarea description en
* med_location input
* med_copyright input

For the images we need some media types

* ht_1000 image height 1000px
* ht_150 thumbnail height 150px
* ht_2000 image height 2000px
* wd300 content image width 300px
* wd_1000 image width 1000px
* wd_150 thumbnail width 150px
* wd_2000 image width 2000px

*At least: use the project plugin to make the php files in /php and the kgdeBackend in /css available.*

Feel free to contact me if you end up in trouble or have some good hints :)





