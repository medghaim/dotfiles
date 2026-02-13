# Personal Claude Code Configuration

## Tool Preferences

### LSP Tool Usage
ALWAYS prefer the LSP tool over Grep/Glob/search tools for any capability that LSP provides.

**Use LSP for:**
- Finding symbol definitions: Use `goToDefinition` instead of grepping for "def function_name" or "class ClassName"
- Finding all references to a symbol: Use `findReferences` instead of grepping for the symbol name
- Getting symbol documentation and type information: Use `hover` instead of reading files to find docstrings
- Finding implementations: Use `goToImplementation` for interfaces/abstract methods
- Exploring call relationships: Use `prepareCallHierarchy`, `incomingCalls`, `outgoingCalls` to understand function calls
- Listing symbols in a file: Use `documentSymbol` to get all functions, classes, variables in a file
- Searching for symbols across workspace: Use `workspaceSymbol` instead of grepping for symbol names

**When to use Grep/Glob:**
- Searching for text patterns that aren't code symbols (comments, strings, documentation)
- Finding files by name patterns (use Glob)
- Searching for code patterns that LSP doesn't handle well (regex patterns, partial matches)
- When LSP servers aren't configured for the file type

**General principle:** If you're looking for a code symbol (function, class, variable, etc.) or its usages, use LSP first. Only fall back to text search tools when LSP cannot provide the information needed.
