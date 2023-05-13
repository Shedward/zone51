//
//  DSL.swift
//  
//
//  Created by Vladislav Maltsev on 13.05.2023.
//

enum Expr {
    case int(Int)
    case `var`(String)
    indirect case add(Expr, Expr)
    indirect case mul(Expr, Expr)
}

extension Expr: Equatable {
}

extension Expr: ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self = .int(value)
    }
}

func description(_ expr: Expr) -> String {
    switch expr {
    case let .var(name):
        return name
    case let .int(value):
        return "\(value)"
    case let .add(lhs, rhs):
        return "(\(description(lhs))) + (\(description(rhs)))"
    case let .mul(lhs, rhs):
        return "(\(description(lhs))) * (\(description(rhs)))"
    }
}

func binaryOpReducer(
    _ expr: @escaping (Expr, Expr) -> Expr,
    _ eval: @escaping (Int, Int) -> (Int),
    _ reduce: @escaping (Expr) -> Expr
) -> (Expr, Expr) -> Expr {
    { lhs, rhs in
        let l = reduce(lhs)
        let r = reduce(rhs)
        switch (l, r) {
        case let (.int(li), .int(ri)):
            return .int(eval(li, ri))
        default:
            return expr(l, r)
        }
    }
}

func reduce(_ expr: Expr, env: [String: Expr] = [:]) -> Expr {
    switch expr {
    case let .var(name):
        if let varExpr = env[name] {
            return reduce(varExpr, env: env)
        } else {
            return expr
        }
    case .int:
        return expr
    case let .add(lhs, rhs):
        return binaryOpReducer(Expr.add, +, { reduce($0, env: env) })(lhs, rhs)
    case let .mul(lhs, rhs):
        return binaryOpReducer(Expr.mul, *, { reduce($0, env: env) })(lhs, rhs)
    }
}

func simplify_1th(_ expr: Expr) -> Expr {
    if case let .mul(lhs, .int(1)) = expr {
        return lhs
    }
    if case let .mul(.int(1), rhs) = expr {
        return rhs
    }
    if case .mul(_, .int(0)) = expr {
        return .int(0)
    }
    if case .mul(.int(0), _) = expr {
        return .int(0)
    }
    if case let .add(lhs, .int(0)) = expr {
        return lhs
    }

    return expr
}

func simplify_nth(_ expr: Expr) -> Expr {
    switch expr {
    case .int, .var:
        return expr
    case let .add(lhs, rhs):
        return .add(simplify_nth(simplify_1th(lhs)), simplify_nth(simplify_1th(rhs)))
    case let .mul(lhs, rhs):
        return .mul(simplify_nth(simplify_1th(lhs)), simplify_nth(simplify_1th(rhs)))
    }
}

func simplify(_ expr: Expr) -> Expr {
    var expr = expr
    while(true) {
        let simplifiedExpr = simplify_nth(expr)
        if simplifiedExpr == expr {
            return expr
        }
        expr = simplifiedExpr
    }
}

func D(_ expr: Expr, by dVar: String) -> Expr {
    switch expr {
    case .int:
        return .int(0)
    case let .var(varName):
        return .int(varName == dVar ? 1 : 0)
    case let .add(lhs, rhs):
        return .add(D(lhs, by: dVar), D(rhs, by: dVar))
    case let .mul(lhs, rhs):
        return .add(.mul(D(lhs, by: dVar), rhs), .mul(lhs, D(rhs, by: dVar)))
    }
}
