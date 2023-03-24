import json
import subprocess

repo = 'https://github.com/purenix-org/purenix-base'
ref = subprocess.Popen(["git", "rev-parse", "HEAD"], stdout=subprocess.PIPE).stdout.readline().decode('utf-8').strip('\n')
result = subprocess.Popen(["nix", "eval", ".#hello.x86_64-linux", "--json"], stdout=subprocess.PIPE).stdout.read()
package_set = json.loads(result)
derivations = list(p['drvPath'] for p in package_set.values())
build_results = subprocess.Popen(["nix-build-results"] + derivations, stdout=subprocess.PIPE).stdout.read()
res = json.loads(build_results)
def update_version(value, subdir):
    if value['version'] == '0.0.0':
        return value | {'version': {'git': repo, 'ref': ref, 'subdir': subdir}}
    else:
        return value
final = {k: res[v['drvPath']] | {"derivation": update_version(v, f'purescript-{k}')} for k, v in package_set.items()}
print(json.dumps(final))
