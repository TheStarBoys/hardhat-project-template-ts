echo "analyzing " $1
contract_root="$1"
# if (($1 == "."))
# then
#     contract_root=`pwd`
rm -rf report/slither
mkdir -p report/slither
slither $contract_root --exclude-dependencies --exclude-informational --exclude-low --exclude-medium > report/slither/high.md --checklist --compile-force-framework foundry --foundry-out-directory cache/forge/out
slither $contract_root --exclude-dependencies --exclude-informational --exclude-low --exclude-high > report/slither/medium.md --checklist --compile-force-framework foundry --foundry-out-directory cache/forge/out
slither $contract_root --exclude-dependencies --exclude-informational --exclude-medium --exclude-high > report/slither/low.md --checklist --compile-force-framework foundry --foundry-out-directory cache/forge/out