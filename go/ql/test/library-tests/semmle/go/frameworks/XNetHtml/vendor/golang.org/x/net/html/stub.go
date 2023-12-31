// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for golang.org/x/net/html, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: golang.org/x/net/html (exports: Node,Token,Tokenizer; functions: EscapeString,UnescapeString,Parse,ParseWithOptions,ParseFragment,ParseFragmentWithOptions,NewTokenizer,Render)

// Package html is a stub of golang.org/x/net/html, generated by depstubber.
package html

import (
	io "io"
)

type Attribute struct {
	Namespace string
	Key       string
	Val       string
}

func EscapeString(_ string) string {
	return ""
}

type Node struct {
	Parent      *Node
	FirstChild  *Node
	LastChild   *Node
	PrevSibling *Node
	NextSibling *Node
	Type        NodeType
	DataAtom    interface{}
	Data        string
	Namespace   string
	Attr        []Attribute
}

func (_ *Node) AppendChild(_ *Node) {}

func (_ *Node) InsertBefore(_ *Node, _ *Node) {}

func (_ *Node) RemoveChild(_ *Node) {}

type NodeType uint32

func Parse(_ io.Reader) (*Node, error) {
	return nil, nil
}

func ParseFragment(_ io.Reader, _ *Node) ([]*Node, error) {
	return nil, nil
}

func ParseFragmentWithOptions(_ io.Reader, _ *Node, _ ...ParseOption) ([]*Node, error) {
	return nil, nil
}

type ParseOption func(interface{})

func ParseWithOptions(_ io.Reader, _ ...ParseOption) (*Node, error) {
	return nil, nil
}

type Token struct {
	Type     TokenType
	DataAtom interface{}
	Data     string
	Attr     []Attribute
}

func (_ Token) String() string {
	return ""
}

type TokenType uint32

func (_ TokenType) String() string {
	return ""
}

type Tokenizer struct{}

func (_ *Tokenizer) AllowCDATA(_ bool) {}

func (_ *Tokenizer) Buffered() []byte {
	return nil
}

func (_ *Tokenizer) Err() error {
	return nil
}

func (_ *Tokenizer) Next() TokenType {
	return 0
}

func (_ *Tokenizer) NextIsNotRawText() {}

func (_ *Tokenizer) Raw() []byte {
	return nil
}

func (_ *Tokenizer) SetMaxBuf(_ int) {}

func (_ *Tokenizer) TagAttr() ([]byte, []byte, bool) {
	return nil, nil, false
}

func (_ *Tokenizer) TagName() ([]byte, bool) {
	return nil, false
}

func (_ *Tokenizer) Text() []byte {
	return nil
}

func (_ *Tokenizer) Token() Token {
	return Token{}
}

func UnescapeString(_ string) string {
	return ""
}

func NewTokenizer(r io.Reader) *Tokenizer {
	return nil
}

func NewTokenizerFragment(r io.Reader, contextTag string) *Tokenizer {
	return nil
}

func Render(w io.Writer, n *Node) error {
	return nil
}
