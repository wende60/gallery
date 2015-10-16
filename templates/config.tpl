<?php

    /**
     * template schwarz-weiss.net config
     * @author: jw
     *
     */

    $document_header_tpl_id     =  8; 
    $document_footer_tpl_id     =  6;     
    $main_navi_tpl_id           =  5;  
    $formmailer_article_id      =  3;

    $language_id                =  (int)$REX["CUR_CLANG"];
    $article_id                 =  (int)$this->getValue("article_id");
    $category_id                =  (int)$this->getValue("category_id");
    $category                   =  OOCategory::getCategoryById($category_id);
    $category_name              =  $category->getName();
    $category_url               =  $category->getUrl();

    $parent                     =  $category->getParent();
    if ($parent) {
        $parent_id      =  (int)$parent->getId();
        $parent_name    =  $parent->getName();
        $parent_url     =  $parent->getUrl();       
    } else {
        $parent_id      =  $category_id;    
        $parent_name    =  $category_name;
        $parent_url     =  $category_url;   
    }    

    $meta_description   =  $this->getValue("description");
    $meta_keywords      =  $this->getValue("keywords");
    $meta_base          = 'http://'.$_SERVER['HTTP_HOST'].'/';

    # use from for -f param for mail
    #
    $formmailer_email_from  =  "kgde@wendenburg.de";
    $formmailer_email_to    =  "kgde@wendenburg.de";
  
?>