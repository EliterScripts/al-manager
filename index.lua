require("miscellaneous")
require("commands")
require("userInterface")
require("settings")
require("history")

rootPath = commands.getPath()
commands.requireRoot()

version = 1

do

    local settings = getSettings()

    local answers = getUserAnswers()


    --mapping the answers
    domain_name = answers[1]
    admin_email = settings.admin_email


    local file = io.open("templates/plaintext.conf", "r")
    local plaintext_template_string = file:read("*all")
    file:close()
    local plaintext_template_map = require("templates/plaintext")

    local plaintext_output_string = string.format(
        plaintext_template_string, 

        unpack(
            plaintext_template_map
        )
    )

    addHistory({
        domain_name = domain_name,
        admin_email = admin_email,
        annotation = "simply creating a website that is simple. Creating HTTP site."
    })

    --writes the plaintext site
    file = io.open("/etc/apache2/sites-available/regular-" .. domain_name .. ".conf", "w")
    file:write(plaintext_output_string)
    file:close()
end