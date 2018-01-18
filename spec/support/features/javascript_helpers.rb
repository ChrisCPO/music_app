module Features
  module Features::JavaScriptHelpers
    def press_enter_on(input)
      script = "var e = jQuery.Event('keypress');"
      script += "e.which = 13;"
      script += "$('#{input}').trigger(e);"
      page.execute_script(script);
    end
  end
end
