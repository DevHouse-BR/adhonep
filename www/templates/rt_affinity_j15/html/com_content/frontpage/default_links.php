<?php // @version $Id: default_links.php 11917 2009-05-29 19:37:05Z ian $
defined('_JEXEC') or die('Restricted access');
?>

<div class="article-info-surround"><div class="article-info-surround2">
<h2>
	<?php echo JText::_('More Articles...'); ?>
</h2>
</div></div>

<ul>
	<?php foreach ($this->links as $link) : ?>
	<li>
		<a class="blogsection" href="<?php echo JRoute::_(ContentHelperRoute::getArticleRoute($link->slug, $link->catslug, $link->sectionid)); ?>">
			<?php echo $this->escape($link->title); ?></a>
	</li>
	<?php endforeach; ?>
</ul>