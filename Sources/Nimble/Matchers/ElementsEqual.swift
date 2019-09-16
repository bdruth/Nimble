/// A Nimble matcher that succeeds when the actual sequence contain the same elements in the same order to the exepected sequence.
public func elementsEqual<Seq1: Sequence, Seq2: Sequence>(_ expectedValue: Seq2?)
    -> Predicate<Seq1> where Seq1.Element: Equatable, Seq1.Element == Seq2.Element
{ //swiftlint:disable:this opening_brace
    // A matcher abstraction for https://developer.apple.com/documentation/swift/sequence/2949668-elementsequal
    return Predicate.define("elementsEqual <\(stringify(expectedValue))>") { (actualExpression, msg) in
        let actualValue = try actualExpression.evaluate()
        switch (expectedValue, actualValue) {
        case (nil, _?):
            return PredicateResult(status: .fail, message: msg.appendedBeNilHint())
        case (nil, nil), (_, nil):
            return PredicateResult(status: .fail, message: msg)
        case (let expected?, let actual?):
            let matches = expected.elementsEqual(actual)
            return PredicateResult(bool: matches, message: msg)
        }
    }
}
