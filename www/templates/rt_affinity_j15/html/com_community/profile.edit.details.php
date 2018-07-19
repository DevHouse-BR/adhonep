<?php // no direct access
defined('_JEXEC') or die('Restricted access'); 

$validPassword = JText::sprintf( JText::_( 'VALID_AZ09', true ), JText::_( 'Password', true ), 4 );
 
?>
<script language="javascript" type="text/javascript">
jQuery.noConflict();

function submitbutton() {	
	var r = new RegExp("[\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-]", "i");
	
	//hide all the error messsage span 1st
	jQuery('#name').removeClass('invalid');
	jQuery('#jspassword').removeClass('invalid');
	jQuery('#jspassword2').removeClass('invalid');
	
	jQuery('#errnamemsg').hide();
	jQuery('#errnamemsg').html('&nbsp');	

	jQuery('#errpasswordmsg').hide();
	jQuery('#errpasswordmsg').html('&nbsp');
	
	jQuery('#errjsemailmsg').hide();
	jQuery('#errjsemailmsg').html('&nbsp');
	
	jQuery('#password').val(jQuery('#jspassword').val());
	jQuery('#password2').val(jQuery('#jspassword2').val());
	
	// do field validation
	var isValid	= true;
	
	if (jQuery('#name').val() == "") {
		isValid = false;
		jQuery('#errnamemsg').html('<?php echo addslashes(JText::_( 'Please enter your name', true ));?>');
		jQuery('#errnamemsg').show();
		jQuery('#name').addClass('invalid');
	}
	
	if(jQuery('#jsemail').val() !=  jQuery('#email').val())
	{
		regex=/^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4}$/;
	   	isValid = regex.test(jQuery('#jsemail').val());
	   	
		var fieldname = jQuery('#jsemail').attr('name');;			       
		if(isValid == false){
			cvalidate.setMessage(fieldname, '', 'CC INVALID EMAIL');
		}	   	
   	}
	
	if(jQuery('#password').val().length > 0 || jQuery('#password2').val().length > 0) {
		//check the password only when the password is not empty!
		if(jQuery('#password').val().length < 6 ){
			isValid = false;
			jQuery('#jspassword').addClass('invalid');
			alert('<?php echo addslashes(JText::_( 'CC PASSWORD TOO SHORT' ));?>');		
		} else if (((jQuery('#password').val() != "") || (jQuery('#password2').val() != "")) && (jQuery('#password').val() != jQuery('#password2').val())){
			isValid = false;			
			jQuery('#jspassword').addClass('invalid');
			jQuery('#jspassword2').addClass('invalid');
			var err_msg = "<?php echo addslashes(JText::_( 'CC PASSWORD NOT SAME' )); ?>";
			alert(err_msg);
		} else if (r.exec(jQuery('#password').val())) {
			isValid = false;		
			jQuery('#errpasswordmsg').html('<?php echo $validPassword; ?>');
			jQuery('#errpasswordmsg').show();
			
			jQuery('#jspassword').addClass('invalid');
		}
	}
		
	if(isValid) {
		//replace the email value.
		jQuery('#email').val(jQuery('#jsemail').val());
		jQuery('#jomsForm').submit();
	}
}
</script>

<div id="profile-edit-details">
<?php
if( $config->get('fbconnectkey') && $config->get('fbconnectsecret') )
{
?>
	<div class="ctitle"><h2><?php echo JText::_('CC ASSOCIATE FACEBOOK LOGIN' );?></h2></div>
<?php
	if( $isAdmin )
	{
?>
	<div class="small facebook"><?php echo JText::_('CC ADMIN NOT ALLOWED TO ASSOCIATE FACEBOOK');?></div>
<?php
	}
	else
	{
		if( $associated )
		{
?>
	<div class="small facebook"><?php echo JText::_('CC ACCOUNT ALREADY MERGED');?></div>
<?php
		}
		else
		{
			if( $config->get('fbconnectkey') && $config->get('fbconnectsecret') )
			{
?>
			<script type="text/javascript" src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php"></script>
			<script type="text/javascript">
				window.addEvent('domready', function()
				{
					FB_RequireFeatures(["XFBML"], function() {
						FB.Facebook.init( "<?php echo $config->get('fbconnectkey');?>" , "index.php?option=com_community&view=connect&task=receiver");
					});
				});
			
			    function FBMerge()
			    {
			            FB.Facebook.get_sessionState().waitUntilReady(
			                    function() {
			                    	joms.connect.mergeNotice();
			                    });
			    }
			</script>
			<div class="white">
				<fb:login-button size="large" background="white" length="long" onlogin="FBMerge();"></fb:login-button>
			</div>
<?php
			}
		}
	}
}
?>
<div class="ctitle">
	<h2><?php echo JText::_('CC YOUR DETAILS');?></h2>
</div>

<form name="jomsForm" id="jomsForm" action="" method="POST">
<table  width="100%" class="paramlist admintable" cellspacing="1">
<tr>
	<td class="paramlist_key">
		<label for="username"><?php echo JText::_( 'User Name' ); ?></label>
	</td>
	<td class="paramlist_value">
		<span><?php echo $user->get('username');?></span>
	</td>
</tr>
<tr>
	<td class="paramlist_key">
		<label id="jsemailmsg"><?php echo JText::_( 'email' ); ?></label>
	</td>
	<td class="paramlist_value">
		<input type="text" class="inputbox" id="jsemail" name="jsemail" value="<?php echo $user->get('email');?>" size="40" />
		<input type="hidden" id="email" name="email" value="<?php echo $user->get('email');?>" size="40" />
	    <input type="hidden" id="emailpass" name="emailpass" id="emailpass" value="<?php echo $user->get('email');?>"/>
	    <span id="errjsemailmsg" style="display:none;">&nbsp;</span>		
	</td>
</tr>
<tr>
	<td class="paramlist_key">
		<label for="name"><?php echo JText::_( 'Your Name' ); ?></label>
	</td>
	<td class="paramlist_value">
		<input class="inputbox" type="text" id="name" name="name" value="<?php echo $user->get('name');?>" size="40" />
		<div style="clear:both;"></div>
		<span id="errnamemsg" style="display:none;">&nbsp;</span>
	</td>
</tr>
<?php
if( !$associated )
{
?>
<?php if($user->get('password')) : ?>
<tr>
	<td class="paramlist_key">
		<label for="jspassword">
			<?php echo JText::_( 'Password' ); ?>
		</label>
	</td>
	<td class="paramlist_value">
		<input id="jspassword" name="jspassword" class="inputbox" type="password" value="" size="40"/>
		<span id="errjspasswordmsg" style="display: none;"> </span>
	</td>
</tr>
<tr>
	<td class="paramlist_key">
		<label for="jspassword2">
			<?php echo JText::_( 'Verify Password' ); ?>
		</label>
	</td>
	<td class="paramlist_value">
		<input id="jspassword2" class="inputbox" type="password" value="" size="40" name="jspassword2"/>
		<span id="errjspassword2msg" style="display:none;"> </span>
		<div style="clear:both;"></div>
		<span id="errpasswordmsg" style="display:none;">&nbsp;</span>
	</td>
</tr>
<?php endif; ?>
<?php
}
?>
</table>
<?php if(isset($params)) :  echo $params->render( 'params' ); endif; ?>

<table  width="100%" class="paramlist admintable" cellspacing="1">
<tr>
	<td class="paramlist_key">
		<label class="hasTip" title="<?php echo JText::_( 'CC DST TIME OFFSET' );?>::<?php echo JText::_('CC DAYLIGHT SAVING OFFSET TOOLTIP');?>" for="daylightsavingoffset">
			<?php echo JText::_( 'CC DAYLIGHT SAVING OFFSET' ); ?>
		</label>
	</td>
	<td class="paramlist_value">
		<?php echo $offsetList; ?>
	</td>
</tr>
<tr>
	<td class="paramlist_key">&nbsp;</td>
	<td class="paramlist_value">
		<input type="submit" name="frmSubmit" onclick="submitbutton(); return false;" class="button2" value="<?php echo JText::_('CC BUTTON SAVE'); ?>" />
	</td>
</tr>
</table>
<input type="hidden" name="username" value="<?php echo $user->get('username');?>" />
<input type="hidden" name="id" value="<?php echo $user->get('id');?>" />
<input type="hidden" name="gid" value="<?php echo $user->get('gid');?>" />
<input type="hidden" name="option" value="com_community" />
<input type="hidden" name="view" value="profile" />
<input type="hidden" name="task" value="save" />
<input type="hidden" id="password" name="password" />
<input type="hidden" id="password2" name="password2" />
<?php echo JHTML::_( 'form.token' ); ?>	
</form>
</div>
