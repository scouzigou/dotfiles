return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
  _   _        __      ___           
 | \ | |       \ \    / (_)          
 |  \| | ___  __\ \  / / _ _ __ ___  
 | . ` |/ _ \/ _ \ \/ / | | '_ ` _ \ 
 | |\  |  __/ (_) \  /  | | | | | | |
 |_| \_|\___|\___/ \/   |_|_| |_| |_|

   	                   [ @stephane ]
    ]]
    opts.config.header = vim.split(logo, "\n")
  end,
}
