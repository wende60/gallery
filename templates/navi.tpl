<?php
    /**
     * template schwarz-weiss naviagation
     * displays categories and it's articles     
     * @author: jw
     *
     */
     function get_subcategories($category, $category_id) {
     
        $sc     =  array();
        $tmp    =  array();
        
        if(count($category->getChildren(true))) {
            foreach($category->getChildren(true) as $subcategory) {
            
                $subcategory_id =  (int)$subcategory->getId();
                $tmp['url']     =  $subcategory->getUrl();
                $tmp['name']    =  $subcategory->getName();
                $tmp['class']   =  ($category_id === $subcategory_id)? 'navi-sub-sel' : 'navi-sub-norm';
                
                if(count(OOArticle::getArticlesOfCategory($subcategory_id, true)) > 1) {
                
                    # loop articles of subcategory
                    foreach(OOArticle::getArticlesOfCategory($subcategory_id, true) as $article) { 
                        if($article->isStartArticle()){
                            continue;
                        }
                        $tmp['url'] =  $article->getUrl();
                        break;
                    }            
                } 
                array_push($sc, $tmp);
            }    
        } 
        # return array subcategories or false
        return count($sc)? $sc : false;
     }
     
     function get_articles($id, $article_id, $language_id) {
     
        $ac     =  array();
        $tmp    =  array();
        
        if(count(OOArticle::getArticlesOfCategory($id, true, $language_id)) > 1) {
        
            foreach(OOArticle::getArticlesOfCategory($id, true, $language_id) as $article) {
                
                $tmp['url']     =  $article->getUrl();
                $tmp['name']    =  $article->getName();
                $tmp['class']   =  ($article_id === (int)$article->getId())? 'navi-sub-sel' : 'navi-sub-norm';
                
                array_push($ac, $tmp);
            }    
        }
        # return array articles or false
        return count($ac)? $ac : false;
     }
?>
<ul>   
    <?php
        # loop categories that are online
        #
        foreach (OOCategory::getRootCategories(true) as $category):

            $id         =  (int)$category->getId();
            $gallery    =  $category->getValue('cat_is_gallery');
            $sc         =  get_subcategories($category, $category_id);
            $ac         =  get_articles($id, $article_id, $language_id);
            $url        =  $category->getUrl();             
             
            # check if categorie is current
            if ($parent_id  === $id) {
                $top_navi_class         =  "navi-top-sel";                
            } else {
                $top_navi_class         =  "navi-top-norm";
            }        
    ?>    
        <li class="<?=$top_navi_class?> <?php echo $gallery ?>">
            <a class="<?php echo $top_link_class?>" href="<?php echo $url?>"><?=$category->getName()?></a>
            <?php if($sc): ?>
                <div>
                    <ul>
                        <?php foreach($sc as $subcategory): ?>
                            <li>
                                <a href="<?php echo $subcategory['url']?>"><?php echo $subcategory['name']?></a>
                            </li>
                        <?php endforeach ?>
                    </ul>
                </div>
            <?php endif?>  
            
            <?php if($ac): ?>
                <div>
                    <ul>
                        <?php foreach($ac as $article): ?>
                            <li class="<?php echo $article['class']?>">
                                <a href="<?php echo $article['url']?>"><?php echo $article['name']?></a>
                            </li>                                    
                        <?php endforeach ?>
                    </ul>
                </div>
            <?php endif ?>                 
        </li>
    <?php endforeach ?>
</ul> 

    
    
    
    
