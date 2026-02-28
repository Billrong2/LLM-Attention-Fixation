from .T1_Rename import T1RenamePass
from .T2_SyntaxNoise import T2SyntaxNoisePass
from .T3_ConstHide import T3ConstHidePass
from .T4_ExprSubst import T4ExprSubstPass
from .T5_BogusCF import T5BogusCFPass
from .T6_Flatten import T6FlattenPass
from .T7_InterProc import T7InterProcPass
from .T8_CallIndirection import T8CallIndirectionPass


def all_passes():
    return [
        T1RenamePass(),
        T2SyntaxNoisePass(),
        T3ConstHidePass(),
        T4ExprSubstPass(),
        T5BogusCFPass(),
        T6FlattenPass(),
        T7InterProcPass(),
        T8CallIndirectionPass(),
    ]
