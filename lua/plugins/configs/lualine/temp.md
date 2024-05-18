{ {
    _on_attach = <function 1>,
    attached_buffers = {
      [3] = true
    },
    cancel_request = <function 2>,
    commands = {},
    config = {
      _on_attach = <function 3>,
      autostart = true,
      capabilities = {
        offsetEncoding = { "utf-16" },
        textDocument = {
          callHierarchy = {
            dynamicRegistration = false
          },
          codeAction = {
            codeActionLiteralSupport = {
              codeActionKind = {
                valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
              }
            },
            dataSupport = true,
            dynamicRegistration = false,
            isPreferredSupport = true,
            resolveSupport = {
              properties = { "edit" }
            }
          },
          completion = {
            completionItem = {
              commitCharactersSupport = true,
              deprecatedSupport = true,
              documentationFormat = { "markdown", "plaintext" },
              insertReplaceSupport = true,
              insertTextModeSupport = {
                valueSet = { 1, 2 }
              },
              labelDetailsSupport = true,
              preselectSupport = true,
              resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits", "sortText", "filterText", "insertText", "textEdit", "insertTextFormat", "insertTextMode" }
              },
              snippetSupport = true,
              tagSupport = {
                valueSet = { 1 }
              }
            },
            completionItemKind = {
              valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
            },
            completionList = {
              itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
            },
            contextSupport = true,
            dynamicRegistration = false,
            insertTextMode = 1
          },
          declaration = {
            linkSupport = true
          },
          definition = {
            linkSupport = true
          },
          documentHighlight = {
            dynamicRegistration = false
          },
          documentSymbol = {
            dynamicRegistration = false,
            hierarchicalDocumentSymbolSupport = true,
            symbolKind = {
              valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
            }
          },
          hover = {
            contentFormat = { "markdown", "plaintext" },
            dynamicRegistration = false
          },
          implementation = {
            linkSupport = true
          },
          publishDiagnostics = {
            relatedInformation = true,
            tagSupport = {
              valueSet = { 1, 2 }
            }
          },
          references = {
            dynamicRegistration = false
          },
          rename = {
            dynamicRegistration = false,
            prepareSupport = true
          },
          semanticTokens = {
            augmentsSyntaxTokens = true,
            dynamicRegistration = false,
            formats = { "relative" },
            multilineTokenSupport = false,
            overlappingTokenSupport = true,
            requests = {
              full = {
                delta = true
              },
              range = false
            },
            serverCancelSupport = false,
            tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
            tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
          },
          signatureHelp = {
            dynamicRegistration = false,
            signatureInformation = {
              activeParameterSupport = true,
              documentationFormat = { "markdown", "plaintext" },
              parameterInformation = {
                labelOffsetSupport = true
              }
            }
          },
          synchronization = {
            didSave = true,
            dynamicRegistration = false,
            willSave = true,
            willSaveWaitUntil = true
          },
          typeDefinition = {
            linkSupport = true
          }
        },
        window = {
          showDocument = {
            support = true
          },
          showMessage = {
            messageActionItem = {
              additionalPropertiesSupport = false
            }
          },
          workDoneProgress = true
        },
        workspace = {
          applyEdit = true,
          configuration = true,
          didChangeWatchedFiles = {
            dynamicRegistration = false,
            relativePatternSupport = true
          },
          semanticTokens = {
            refreshSupport = true
          },
          symbol = {
            dynamicRegistration = false,
            hierarchicalWorkspaceSymbolSupport = true,
            symbolKind = {
              valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
            }
          },
          workspaceEdit = {
            resourceOperations = { "rename", "create", "delete" }
          },
          workspaceFolders = true
        }
      },
      cmd = { "/Users/liuxin/.local/share/nvim/mason/bin/lua-language-server" },
      cmd_cwd = "/Users/liuxin/.config/nvim",
      filetypes = { "lua" },
      flags = {},
      get_language_id = <function 4>,
      handlers = <1>{},
      init_options = vim.empty_dict(),
      log_level = 2,
      message_level = 2,
      name = "lua_ls",
      on_attach = <function 5>,
      on_exit = <function 6>,
      on_init = <function 7>,
      root_dir = "/Users/liuxin/.config/nvim",
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          },
          workspace = {
            library = {
              ["/Users/liuxin/.config/nvim/lua"] = true,
              ["/usr/local/Cellar/neovim/0.9.5/share/nvim/runtime/lua"] = true
            }
          }
        }
      },
      single_file_support = true,
      workspace_folders = <2>{ {
          name = "/Users/liuxin/.config/nvim",
          uri = "file:///Users/liuxin/.config/nvim"
        } },
      <metatable> = <3>{
        __tostring = <function 8>
      }
    },
    handlers = <table 1>,
    id = 1,
    initialized = true,
    is_stopped = <function 9>,
    messages = {
      messages = {},
      name = "lua_ls",
      progress = {
        [2] = {
          done = true,
          percentage = 100,
          title = "Loading workspace"
        },
        [3] = {
          done = true,
          percentage = 98,
          title = "Loading workspace"
        }
      },
      status = {}
    },
    name = "lua_ls",
    notify = <function 10>,
    offset_encoding = "utf-16",
    request = <function 11>,
    request_sync = <function 12>,
    requests = {
      [540] = {
        bufnr = 3,
        method = "textDocument/documentHighlight",
        type = "pending"
      }
    },
    rpc = {
      is_closing = <function 13>,
      notify = <function 14>,
      request = <function 15>,
      terminate = <function 16>
    },
    server_capabilities = {
      codeActionProvider = {
        codeActionKinds = { "", "quickfix", "refactor.rewrite", "refactor.extract" },
        resolveProvider = false
      },
      codeLensProvider = {
        resolveProvider = true
      },
      colorProvider = true,
      completionProvider = {
        resolveProvider = true,
        triggerCharacters = { "\t", "\n", ".", ":", "(", "'", '"', "[", ",", "#", "*", "@", "|", "=", "-", "{", " ", "+", "?" }
      },
      definitionProvider = true,
      documentFormattingProvider = true,
      documentHighlightProvider = true,
      documentOnTypeFormattingProvider = {
        firstTriggerCharacter = "\n"
      },
      documentRangeFormattingProvider = true,
      documentSymbolProvider = true,
      executeCommandProvider = {
        commands = { "lua.removeSpace", "lua.solve", "lua.jsonToLua", "lua.setConfig", "lua.getConfig", "lua.autoRequire" }
      },
      foldingRangeProvider = true,
      hoverProvider = true,
      implementationProvider = true,
      inlayHintProvider = {
        resolveProvider = true
      },
      offsetEncoding = "utf-16",
      referencesProvider = true,
      renameProvider = {
        prepareProvider = true
      },
      semanticTokensProvider = {
        full = true,
        legend = {
          tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary", "global" },
          tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
        },
        range = true
      },
      signatureHelpProvider = {
        triggerCharacters = { "(", "," }
      },
      textDocumentSync = {
        change = 2,
        openClose = true,
        save = {
          includeText = false
        }
      },
      typeDefinitionProvider = true,
      workspace = {
        fileOperations = {
          didRename = {
            filters = { {
                pattern = {
                  glob = "/Users/liuxin/.config/nvim/**",
                  options = {
                    ignoreCase = true
                  }
                }
              } }
          }
        },
        workspaceFolders = {
          changeNotifications = true,
          supported = true
        }
      },
      workspaceSymbolProvider = true
    },
    stop = <function 17>,
    supports_method = <function 18>,
    workspace_did_change_configuration = <function 19>,
    workspace_folders = <table 2>
  } }
