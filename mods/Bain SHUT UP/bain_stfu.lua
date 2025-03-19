local banned_list = {
	["Play_ban_c01"] = true,
	["Play_loc_c01"] = true,
} 

local original_queueDialog = DialogManager.queue_dialog
function DialogManager:queue_dialog( id, ... )
   if banned_list[id]  then
        return
   end
   return original_queueDialog(self, id, ...)
end