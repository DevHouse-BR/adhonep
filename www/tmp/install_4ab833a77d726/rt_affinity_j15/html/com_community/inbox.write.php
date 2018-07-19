<?php
/**
 * @package		JomSocial
 * @subpackage 	Template 
 * @copyright (C) 2008 by Slashes & Dots Sdn Bhd - All rights reserved!
 * @license http://www.azrul.com Copyrighted Commercial Software
 */
defined('_JEXEC') or die();
?>
<script type="text/javascript">
function disableFormField(){

	//change the background color to light grey
	document.getElementById('to').style.backgroundColor      = "#cfcfcf";
	document.getElementById('subject').style.backgroundColor = "#cfcfcf";
	document.getElementById('message-body').style.backgroundColor    = "#cfcfcf";

    //text field
	document.getElementById('to').readonly = true;
	document.getElementById('subject').readonly = true;
	document.getElementById('message-body').readonly = true;

    //button
    document.getElementById('submitBtn').disabled = true;
    //document.getElementById('cancelBtn').disabled = true;

}//end disableFormField

var yPos;

function addFriendName()
{
    var curr = jQuery('#to').val();
    var inputs = [];
    jQuery('#selections option:selected').each( function() {
		inputs.push(this.value);
	});

    var x = inputs.join(', ');
    jQuery('#to').val(x);
}

</script>
<div class="app-box"><div clas="form-surround">
<form name="writeMessageForm" class="community-form-validate composeForm" id="writeMessageForm" action="<?php echo CRoute::getURI(); ?>" method="post" onsubmit="disableFormField();">
<?php
if( $totalSent >=  $maxSent )
{
?>
<div class="error-box"><?php echo JText::_('CC PM LIMIT REACHED');?></div>
<?php
}
else
{
?>
<div style="text-align: right;">
<?php echo JText::sprintf('CC PM LIMIT' , $maxSent);?>
</div>
<div style="text-align: right;">
<?php echo JText::sprintf('CC PM LIMIT REMAINING' , $totalSent , $maxSent);?>
</div>
<table cellpadding="0" cellspacing="0" border="0" width="98%">
	<tr>
	    <td>
			<dl class="2cols">
			    <dt class="col-left"><label for="to"><?php echo JText::_('CC COMPOSE TO USERNAME'); ?> :</label></dt>
			    <dd class="col-right"><input id="to" name="to" class="inputbox required text ac_input" type="text" autocomplete="off" value="<?php echo $data->to; ?>" /></dd>

			    <dt class="col-left"><label for="subject"><?php echo JText::_('CC COMPOSE SUBJECT'); ?> :</label></dt>
			    <dd class="col-right"><input id="subject" class="inputbox required text" name="subject" type="text" value="<?php echo $data->subject; ?>"/></dd>

			    <dt class="col-left"><label for="body" style="text-align:top;"><?php echo JText::_('CC COMPOSE MESSAGE'); ?> :</label></dt>
			    <dd class="col-right">
					<textarea id="message-body" name="body" class="inputbox required textarea"><?php echo $data->body; ?></textarea>
					<div>
                    <input type="hidden" name="action" value="doSubmit"/>
							<div class="readon-wrap1"><div class="readon1-l"></div><a class="readon-main"><span class="readon1-m"><span class="readon1-r"><input id="submitBtn" class="button validateSubmit" name="submitBtn" type="submit" value="<?php echo JText::_('CC BUTTON SUBMIT'); ?>" /></span></span></a></div><div class="clr"></div>					
					</div>
				</dd>
			</dl>

            <div class="clr"></div>
		</td>
	    <td width="150">
			<div class="receiverList" style="text-align: center;">
		    	<select size="15" id="selections" name="selections[]" class="inputbox text">
		    	    <optgroup label="<?php echo JText::_('CC FRIENDS LIST');?>">
						<?php foreach ( $rows as $row ) : ?>
						<option value="<?php echo $row->username; ?>" id="<?php echo $row->id; ?>"><?php echo $row->getDisplayName(); ?></option>
						<?php endforeach; ?>
					</optgroup>
			    </select>
			    <input type="button" onclick="addFriendName();" class="button" value="<?php echo JText::_('CC BUTTON ADD AS RECIPIENT'); ?>" style="margin: 5px 0 0; width: 140px;" />
			</div>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript">
    cvalidate.init();
</script>
<?php
}
?>
</div></div>