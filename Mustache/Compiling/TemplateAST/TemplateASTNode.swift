// The MIT License
//
// Copyright (c) 2015 Gwendal Roué
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import Foundation

enum TemplateASTNode {
    struct InheritableSectionDescriptor {
        let templateAST: TemplateAST
        let name: String
    }
    struct InheritedPartialDescriptor {
        let templateAST: TemplateAST
        let partial: PartialDescriptor
    }
    struct PartialDescriptor {
        let templateAST: TemplateAST
        let name: String?
    }
    struct SectionDescriptor {
        let templateAST: TemplateAST
        let expression: Expression
        let inverted: Bool
        let openingToken: TemplateToken
        let innerTemplateString: String
    }
    struct TextDescriptor {
        let text: String
    }
    struct VariableDescriptor {
        let expression: Expression
        let contentType: ContentType
        let escapesHTML: Bool
        let token: TemplateToken
    }
    
    case InheritableSection(InheritableSectionDescriptor)
    case InheritedPartial(InheritedPartialDescriptor)
    case Partial(PartialDescriptor)
    case Section(SectionDescriptor)
    case Text(TextDescriptor)
    case Variable(VariableDescriptor)
    
    static func text(# text: String) -> TemplateASTNode {
        return .Text(TextDescriptor(text: text))
    }
    static func variable(# expression: Expression, contentType: ContentType, escapesHTML: Bool, token: TemplateToken) -> TemplateASTNode {
        return .Variable(VariableDescriptor(expression: expression, contentType: contentType, escapesHTML: escapesHTML, token: token))
    }
    static func section(# templateAST: TemplateAST, expression: Expression, inverted: Bool, openingToken: TemplateToken, innerTemplateString: String) -> TemplateASTNode {
        return .Section(SectionDescriptor(templateAST: templateAST, expression: expression, inverted: inverted, openingToken: openingToken, innerTemplateString: innerTemplateString))
    }
    static func partial(# templateAST: TemplateAST, name: String?) -> TemplateASTNode {
        return .Partial(PartialDescriptor(templateAST: templateAST, name: name))
    }
    static func inheritedPartial(# templateAST: TemplateAST, inheritedTemplateAST: TemplateAST, inheritedPartialName: String?) -> TemplateASTNode {
        return .InheritedPartial(InheritedPartialDescriptor(templateAST: templateAST, partial: PartialDescriptor(templateAST: inheritedTemplateAST, name: inheritedPartialName)))
    }
    static func inheritableSection(# templateAST: TemplateAST, name: String) -> TemplateASTNode {
        return .InheritableSection(InheritableSectionDescriptor(templateAST: templateAST, name: name))
    }
}
