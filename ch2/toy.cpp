#include <iostream>
#include <cstdio>

/* 词法分析器token类型 */
enum Token_Type {
    EOF_TOKEN   = 0,    /* EOF */
    NUMERIC_TOKEN,      /* 数值 */
    IDENTIFIER_TOKEN,   /* 标识符 */
    PARAN_TOKEN,        /* 括号 */
    DEF_TOKEN           /* def声明函数 */
};

/* 数值 */
static int Numeric_Val;

/* 标识符字符串 */
static std::string Identifier_string;

FILE* file;

static int get_token() {
    static int LastChar = ' ';

    // fetch the first valid char
    while (isspace(LastChar))
        LastChar = fgetc(file);

    // fetch a whole identifier or def
    if (isalpha(LastChar)) {
        Identifier_string = LastChar;
        while (isalnum((LastChar = fgetc(file))))
            Identifier_string += LastChar;
        
        // def
        if (Identifier_string == "def")
            return DEF_TOKEN;
        
        // identifier
        return IDENTIFIER_TOKEN;
    }

    // numeric
    if (isdigit(LastChar)) {
        std::string numStr;
        do {
            numStr += LastChar;
            LastChar = fgetc(file);
        } while (isdigit(LastChar));

        Numeric_Val = strtod(numStr.c_str(), nullptr);
        return NUMERIC_TOKEN;
    }

    // single line comment
    if (LastChar == '#') {
        do LastChar = fgetc(file);
        while (LastChar != EOF && LastChar != '\n' && LastChar != '\r');

        if (LastChar == EOF)
            return EOF_TOKEN;

        int ThisChar = LastChar;
        LastChar = fgetc(file);
        return ThisChar;
    }
}

void lexer() {
    file = fopen("source.toy", "r");
    if (file == nullptr) return;

    int val = get_token();
    while (val != EOF_TOKEN) {
        std::cout << val << std::endl;
        val = get_token();
    }
}

int main() {
    lexer();
    return 0;
}