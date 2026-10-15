function root = select_a_root(select_a)
%SELECT_A_ROOT  The a-root ("low" or "high") behind a "Select aᵢ" choice.
%   root = select_a_root(select_a) maps each entry of the Physical-parameters
%   table's "Select aᵢ" column to the root of the a(Hcr, m(Hcr)) equation it
%   currently uses, as a string column: 'auto (low)' and 'low' give "low",
%   'auto (high)' and 'high' give "high". The auto modes start on the named
%   root and may move to the other one during a fit (see
%   AnhystereticUtils.auto_explore_roots); everything that computes with the
%   root only needs which one is current. Empty or unknown entries give
%   "low", the long-standing default.

    root = lower(strtrim(string(select_a(:))));
    root = strtrim(erase(root, ["auto", "(", ")"]));
    root(root ~= "high") = "low";
end
