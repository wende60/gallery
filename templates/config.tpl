<?php

    /**
     * template schwarz-weiss.net config
     * @author: jw
     *
     */

    $formmailerArticleId = 3;

    $languageId = REX_CLANG_ID;
    $articleId = REX_ARTICLE_ID;
    $categoryId = REX_CATEGORY_ID;

    $langAll = rex_clang::getAll();
    $langCode = $langAll[$languageId]->getValue('code');
    $langName = $langAll[$languageId]->getValue('name');

    # use from for -f param for mail
    $formmailer_email_from =  "kgde@wendenburg.de";
    $formmailer_email_to =  "kgde@wendenburg.de";

?>