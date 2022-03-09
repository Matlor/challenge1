import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";


module {
    
    type List<T> = ?(T, List<T>);


    // the <T> on the function probably means something 
    // like, I take a type as parameter.
    public func is_null<T>(l: List<T>): Bool {
        switch(l){
            case(null){
                return true;
            };
            case(?list){
                return false;
            };

        };
    };


    public func last<T>(l: List<T>): ?T {
            switch(l){
                case(null){
                    return null;
                };
                case(?(x, null)){
                    return ?x;
                };
                case(?(x, list)){
                    last(list);
                };
            };
    };

    public func size<T>(l: List<T>): Nat {
        var counter: Nat = 0;
        var isNull = true;
        var list = l;   
        while(isNull == true){
            switch(list){
                case(null){
                    isNull := false;
                };
                case(?(x, node)){
                    counter +=1;
                    list:= node;
                };
            };
            
        };
        return counter;
    };


    public func get<T>(l: List<T>, n:Nat): ?T {
        var counter: Nat = 0;
        var isNull = false;
        var list = l;   
        while(isNull == false){
            switch(list){
                case(null){
                    isNull := true;
                };
                case(?(x, node)){
                    if(n == counter){
                        return ?x;
                    };
                    counter +=1;
                    list:= node;
                };
            };
            
        };
        return null;
    };

    public func reverse<T>(l : List<T>) : List<T> {
        func rec(l : List<T>, r : List<T>) : List<T> {
            switch l {
                case null { r };
                case (?(h, t)) { rec(t, ?(h, r)) };
            }
        };
        rec(l, null)
    };

};