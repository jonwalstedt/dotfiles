return {
    formatCommand = ([[
        ./node_modules/.bin/prettier
        ${--config-precedence:preferFile}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub(
        "\n",
        ""
    )
}
