%{
  configs: [
    %{
      name: "default",
      checks: %{
        disabled: [
          {Credo.Check.Readability.ModuleDoc, false}
        ]
      }
      # files etc.
    }
  ]
}
