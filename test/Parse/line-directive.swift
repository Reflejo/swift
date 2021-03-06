// RUN: %target-parse-verify-swift

let x = 0 // We need this because of the #sourceLocation-ends-with-a-newline requirement.

#sourceLocation()
x // expected-error {{parameterless closing #sourceLocation() directive without prior opening #sourceLocation(file:,line:) directive}}

#sourceLocation(file: "x", line: 0) // expected-error{{the line number needs to be greater}}

#sourceLocation(file: "x", line: -1) // expected-error{{expected starting line number}}

#sourceLocation(file: "x", line: 1.5) // expected-error{{expected starting line number}}

#sourceLocation(file: x.swift, line: 1) // expected-error{{expected filename string literal}}

#sourceLocation(file: "x.swift", line: 42)
x x ; // should be ignored by expected_error because it is in a different file
x
#sourceLocation()
x
x x // expected-error{{consecutive statements}} {{2-2=;}}

// rdar://19582475
public struct S { // expected-note{{in declaration of 'S'}}
// expected-error@+1{{expected declaration}}
/ ###line 25 "line-directive.swift"
}
// expected-warning@+1{{#line directive is deprecated, please use #sourceLocation instead}}
#line 32000 "troops_on_the_water"

#sourceLocation()


// expected-warning@+1{{#line directive is deprecated, please use #sourceLocation instead}}
#setline 32000 "troops_on_the_water"
