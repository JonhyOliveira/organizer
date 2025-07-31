require "rails/generators"
require "rails/generators/actions"
require "generators/tailwindcss/scaffold/scaffold_generator"

class ScaffoldGenerator < Tailwindcss::Generators::ScaffoldGenerator
  source_root File.expand_path("templates", __dir__)
end
