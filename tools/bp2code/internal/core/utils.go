package core

import "unicode"

func Capitalize(s string) string {
	return string(unicode.ToUpper(rune(s[0]))) + s[1:]
}
