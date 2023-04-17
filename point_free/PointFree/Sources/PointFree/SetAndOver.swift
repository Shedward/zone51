//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 20.12.2022.
//

import Foundation

prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
    -> (@escaping (Value) -> Value)
    -> (Root) -> Root {

    prop(kp)
}

typealias Setter<ValueIn, ValueOut, RootIn, RootOut> = (@escaping (ValueIn) -> ValueOut) -> (RootIn) -> RootOut

func over<RootIn, RootOut, ValueIn, ValueOut>(
    _ setter: Setter<ValueIn, ValueOut, RootIn, RootOut>,
    _ f: @escaping (ValueIn) -> ValueOut
) -> (RootIn) -> RootOut {
    setter(f)
}

func set<RootIn, RootOut, ValueIn, ValueOut>(
    _ setter: Setter<ValueIn, ValueOut, RootIn, RootOut>,
    _ value: ValueOut
) -> (RootIn) -> RootOut {
    over(setter, { _ in value })
}
