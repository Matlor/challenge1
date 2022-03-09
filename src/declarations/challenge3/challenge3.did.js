export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'init_count' : IDL.Func([IDL.Nat], [IDL.Vec(IDL.Nat)], []),
    'seven' : IDL.Func([IDL.Vec(IDL.Nat)], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
