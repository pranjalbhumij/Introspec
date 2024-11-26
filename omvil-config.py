#  omvil-config.py
#  ZunuMailApp
#
#  Created by Abhigyan Gogoi on 12/11/24.
#

import omvll
from functools import lru_cache

class Config(omvll.ObfuscationConfig):
    def __init__(self):
        super().__init__()

    def obfuscate_symbol(self, mod, symbol):
        return "obfuscated_" + symbol.name

    def flatten_cfg(self, mod: omvll.Module, func: omvll.Function):
        return True

    def obfuscate_string(self, mod, func, string: bytes):
        return "REDACTED"
        
    def obfuscate_constants(_, module: omvll.Module, func: omvll.Function):
#        if "testFunctionForObfuscation" in func.demangled_name:
#            # Only obfuscate the constants that are in this list
#            return True
        return True
        
    def obfuscate_arithmetic(self, mod: omvll.Module, fun: omvll.Function) -> omvll.ArithmeticOpt:
        return True

@lru_cache(maxsize=1)
def omvll_get_config() -> omvll.ObfuscationConfig:
    """
    Return an instance of `ObfuscationConfig` which
    aims at describing the obfuscation scheme
    """
    return Config()
