local util = {}

-- run debug
function util.get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

function util.run_java_test_method(debug)
  local utils = require("utils")
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd("term " .. util.get_test_runner(method_name, debug))
end

function util.run_java_test_class(debug)
  local utils = require("utils")
  local class_name = utils.get_current_full_class_name()
  vim.cmd("term " .. util.get_test_runner(class_name, debug))
end

function util.get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param =
      ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return "mvn spring-boot:run " .. profile_param .. debug_param
end

function util.run_spring_boot()
  local profile = vim.fn.input("Enter a profile to run: ")
  vim.cmd("term " .. util.get_spring_boot_runner(profile, false))
end
function util.debug_spring_boot()
  local profile = vim.fn.input("Enter a profile to debug: ")
  vim.cmd("term " .. util.get_spring_boot_runner(profile, true))
end

function util.show_dap_centered_scopes()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end

function util.attach_to_debug()
  local dap = require("dap")
  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Attach to the process",
      hostName = "localhost",
      port = "5005",
    },
  }
  dap.continue()
end

function util.setup_Keys()
  vim.keymap.set("n", "<leader>tj", "<cmd> lua require('jdtls').test_class() <cr>", {
    desc = "Test the current class",
  })
  vim.keymap.set("n", "<leader>tn", "<cmd> lua require('jdtls').test_nearest_method() <cr>", {
    desc = "Test the nearest method",
  })
  vim.keymap.set("n", "<Leader>jr", util.run_spring_boot, {
    noremap = true,
    desc = "running a java application with a profile",
  })
  vim.keymap.set("n", "<Leader>jd", util.debug_spring_boot, {
    noremap = true,
    desc = "debug a java application with a profile",
  })
  vim.keymap.set("n", "<Leader>da", util.attach_to_debug, {
    noremap = true,
    desc = "attach to debug",
  })

  -- debug keys
  vim.keymap.set("n", "<F5>", ":lua require('dap').continue()  <cr>", {
    noremap = true,
    desc = "Continue Debugging",
  })
  vim.keymap.set("n", "<F6>", ":lua require('dap').step_over()  <cr>", {
    noremap = true,
    desc = "Step Over Debugging",
  })
  vim.keymap.set("n", "<F7>", ":lua require('dap').step_into()  <cr>", {
    noremap = true,
    desc = "Step Into Debugging",
  })
  vim.keymap.set("n", "<F8>", ":lua require('dap').step_out()  <cr>", {
    noremap = true,
    desc = "Step Out Debugging",
  })
end

return util
