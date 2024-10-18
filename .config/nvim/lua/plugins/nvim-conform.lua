return {

    'stevearc/conform.nvim',
    opts = {
        notify_on_error = false,
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
    formatters_by_ft = {
        go = {"gofmt"},
    }
}
