# Make file for Scintilla on Windows Visual C++ version
# Copyright 1998-2010 by Neil Hodgson <neilh@scintilla.org>
# The License.txt file describes the conditions under which this software may be distributed.
# This makefile is for using Visual C++ with nmake.
# Usage for Microsoft:
#     nmake -f scintilla.mak
# For debug versions define DEBUG on the command line:
#     nmake DEBUG=1 -f scintilla.mak
# The main makefile uses mingw32 gcc and may be more current than this file.

.SUFFIXES: .cxx

DIR_O=.
DIR_BIN=..\bin

COMPONENT=$(DIR_BIN)\Scintilla.dll
LEXCOMPONENT=$(DIR_BIN)\SciLexer.dll
LIBSCI=$(DIR_BIN)\libscintilla.lib

LD=link

!IFDEF SUPPORT_XP
XP_DEFINE=-D_USING_V110_SDK71_
XP_LINK=-SUBSYSTEM:WINDOWS,5.01
!ENDIF

CRTFLAGS=-D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=1 -D_CRT_SECURE_NO_DEPRECATE=1 -D_SCL_SECURE_NO_WARNINGS=1 $(XP_DEFINE)
CXXFLAGS=-Zi -TP -MP -W4 -EHsc $(CRTFLAGS)
CXXDEBUG=-Od -MTd -DDEBUG
CXXNDEBUG=-O1 -MT -DNDEBUG -GL
NAME=-Fo
LDFLAGS=-OPT:REF -LTCG -IGNORE:4197 -DEBUG $(XP_LINK)
LDDEBUG=
LIBS=KERNEL32.lib USER32.lib GDI32.lib IMM32.lib OLE32.lib OLEAUT32.lib MSIMG32.lib
NOLOGO=-nologo

!IFDEF QUIET
CXX=@$(CXX)
CXXFLAGS=$(CXXFLAGS) $(NOLOGO)
LDFLAGS=$(LDFLAGS) $(NOLOGO)
!ENDIF

!IF [cl -c -nologo CheckD2D.cxx >NUL:]
CXXFLAGS=$(CXXFLAGS) -DDISABLE_D2D
!MESSAGE Direct2D is not available
!ENDIF

!IFDEF NO_CXX11_REGEX
CXXFLAGS=$(CXXFLAGS) -DNO_CXX11_REGEX
!ENDIF

!IFDEF DEBUG
CXXFLAGS=$(CXXFLAGS) $(CXXDEBUG)
LDFLAGS=$(LDDEBUG) $(LDFLAGS)
!ELSE
CXXFLAGS=$(CXXFLAGS) $(CXXNDEBUG)
!ENDIF

INCLUDEDIRS=-I../include -I../src -I../lexlib
CXXFLAGS=$(CXXFLAGS) $(INCLUDEDIRS)

all:	$(COMPONENT) $(LEXCOMPONENT) $(LIBSCI)

clean:
	-del /q $(DIR_O)\*.obj $(DIR_O)\*.pdb $(DIR_O)\*.asm $(COMPONENT) $(LEXCOMPONENT) \
	$(DIR_O)\*.res $(DIR_BIN)\*.map $(DIR_BIN)\*.exp $(DIR_BIN)\*.pdb $(DIR_BIN)\*.lib

# Required for base Scintilla
BASEOBJS=\
	$(DIR_O)\AutoComplete.obj \
	$(DIR_O)\CallTip.obj \
	$(DIR_O)\CaseConvert.obj \
	$(DIR_O)\CaseFolder.obj \
	$(DIR_O)\CellBuffer.obj \
	$(DIR_O)\CharacterCategory.obj \
	$(DIR_O)\CharacterSet.obj \
	$(DIR_O)\CharClassify.obj \
	$(DIR_O)\ContractionState.obj \
	$(DIR_O)\DBCS.obj \
	$(DIR_O)\Decoration.obj \
	$(DIR_O)\Document.obj \
	$(DIR_O)\EditModel.obj \
	$(DIR_O)\Editor.obj \
	$(DIR_O)\EditView.obj \
	$(DIR_O)\Indicator.obj \
	$(DIR_O)\KeyMap.obj \
	$(DIR_O)\LineMarker.obj \
	$(DIR_O)\MarginView.obj \
	$(DIR_O)\PerLine.obj \
	$(DIR_O)\PlatWin.obj \
	$(DIR_O)\PositionCache.obj \
	$(DIR_O)\PropSetSimple.obj \
	$(DIR_O)\RESearch.obj \
	$(DIR_O)\RunStyles.obj \
	$(DIR_O)\Selection.obj \
	$(DIR_O)\Style.obj \
	$(DIR_O)\UniConversion.obj \
	$(DIR_O)\ViewStyle.obj \
	$(DIR_O)\XPM.obj \
	$(DIR_O)\HanjaDic.obj \

SOBJS=\
	$(BASEOBJS) \
	$(DIR_O)\ScintillaBase.obj \
	$(DIR_O)\ScintillaWin.obj

#++Autogenerated -- run scripts/LexGen.py to regenerate
#**LEXOBJS=\\\n\(\t$(DIR_O)\\\*.obj \\\n\)
LEXOBJS=\
	$(DIR_O)\LexA68k.obj \
	$(DIR_O)\LexAbaqus.obj \
	$(DIR_O)\LexAda.obj \
	$(DIR_O)\LexAPDL.obj \
	$(DIR_O)\LexAsm.obj \
	$(DIR_O)\LexAsn1.obj \
	$(DIR_O)\LexASY.obj \
	$(DIR_O)\LexAU3.obj \
	$(DIR_O)\LexAVE.obj \
	$(DIR_O)\LexAVS.obj \
	$(DIR_O)\LexBaan.obj \
	$(DIR_O)\LexBash.obj \
	$(DIR_O)\LexBasic.obj \
	$(DIR_O)\LexBatch.obj \
	$(DIR_O)\LexBibTeX.obj \
	$(DIR_O)\LexBullant.obj \
	$(DIR_O)\LexCaml.obj \
	$(DIR_O)\LexCLW.obj \
	$(DIR_O)\LexCmake.obj \
	$(DIR_O)\LexCOBOL.obj \
	$(DIR_O)\LexCoffeeScript.obj \
	$(DIR_O)\LexConf.obj \
	$(DIR_O)\LexCPP.obj \
	$(DIR_O)\LexCrontab.obj \
	$(DIR_O)\LexCsound.obj \
	$(DIR_O)\LexCSS.obj \
	$(DIR_O)\LexD.obj \
	$(DIR_O)\LexDiff.obj \
	$(DIR_O)\LexDMAP.obj \
	$(DIR_O)\LexDMIS.obj \
	$(DIR_O)\LexECL.obj \
	$(DIR_O)\LexEDIFACT.obj \
	$(DIR_O)\LexEiffel.obj \
	$(DIR_O)\LexErlang.obj \
	$(DIR_O)\LexErrorList.obj \
	$(DIR_O)\LexEScript.obj \
	$(DIR_O)\LexFlagship.obj \
	$(DIR_O)\LexForth.obj \
	$(DIR_O)\LexFortran.obj \
	$(DIR_O)\LexGAP.obj \
	$(DIR_O)\LexGui4Cli.obj \
	$(DIR_O)\LexHaskell.obj \
	$(DIR_O)\LexHex.obj \
	$(DIR_O)\LexHTML.obj \
	$(DIR_O)\LexIndent.obj \
	$(DIR_O)\LexInno.obj \
	$(DIR_O)\LexJSON.obj \
	$(DIR_O)\LexKix.obj \
	$(DIR_O)\LexKVIrc.obj \
	$(DIR_O)\LexLaTeX.obj \
	$(DIR_O)\LexLisp.obj \
	$(DIR_O)\LexLout.obj \
	$(DIR_O)\LexLPeg.obj \
	$(DIR_O)\LexLua.obj \
	$(DIR_O)\LexMagik.obj \
	$(DIR_O)\LexMake.obj \
	$(DIR_O)\LexMarkdown.obj \
	$(DIR_O)\LexMatlab.obj \
	$(DIR_O)\LexMaxima.obj \
	$(DIR_O)\LexMetapost.obj \
	$(DIR_O)\LexMMIXAL.obj \
	$(DIR_O)\LexModula.obj \
	$(DIR_O)\LexMPT.obj \
	$(DIR_O)\LexMSSQL.obj \
	$(DIR_O)\LexMySQL.obj \
	$(DIR_O)\LexNimrod.obj \
	$(DIR_O)\LexNsis.obj \
	$(DIR_O)\LexNull.obj \
	$(DIR_O)\LexOpal.obj \
	$(DIR_O)\LexOScript.obj \
	$(DIR_O)\LexPascal.obj \
	$(DIR_O)\LexPB.obj \
	$(DIR_O)\LexPerl.obj \
	$(DIR_O)\LexPLM.obj \
	$(DIR_O)\LexPO.obj \
	$(DIR_O)\LexPOV.obj \
	$(DIR_O)\LexPowerPro.obj \
	$(DIR_O)\LexPowerShell.obj \
	$(DIR_O)\LexProgress.obj \
	$(DIR_O)\LexProps.obj \
	$(DIR_O)\LexPS.obj \
	$(DIR_O)\LexPython.obj \
	$(DIR_O)\LexR.obj \
	$(DIR_O)\LexRebol.obj \
	$(DIR_O)\LexRegistry.obj \
	$(DIR_O)\LexRuby.obj \
	$(DIR_O)\LexRust.obj \
	$(DIR_O)\LexScriptol.obj \
	$(DIR_O)\LexSmalltalk.obj \
	$(DIR_O)\LexSML.obj \
	$(DIR_O)\LexSorcus.obj \
	$(DIR_O)\LexSpecman.obj \
	$(DIR_O)\LexSpice.obj \
	$(DIR_O)\LexSQL.obj \
	$(DIR_O)\LexSTTXT.obj \
	$(DIR_O)\LexTACL.obj \
	$(DIR_O)\LexTADS3.obj \
	$(DIR_O)\LexTAL.obj \
	$(DIR_O)\LexTCL.obj \
	$(DIR_O)\LexTCMD.obj \
	$(DIR_O)\LexTeX.obj \
	$(DIR_O)\LexTxt2tags.obj \
	$(DIR_O)\LexVB.obj \
	$(DIR_O)\LexVerilog.obj \
	$(DIR_O)\LexVHDL.obj \
	$(DIR_O)\LexVisualProlog.obj \
	$(DIR_O)\LexYAML.obj \

#--Autogenerated -- end of automatically generated section

# Required by lexers
LEXLIBOBJS=\
	$(DIR_O)\Accessor.obj \
	$(DIR_O)\Catalogue.obj \
	$(DIR_O)\ExternalLexer.obj \
	$(DIR_O)\DefaultLexer.obj \
	$(DIR_O)\LexerBase.obj \
	$(DIR_O)\LexerModule.obj \
	$(DIR_O)\LexerSimple.obj \
	$(DIR_O)\StyleContext.obj \
	$(DIR_O)\WordList.obj \

# Required by libraries and DLLs that include lexing
SCILEXOBJS=\
	$(BASEOBJS) \
	$(LEXLIBOBJS) \
	$(LEXOBJS) \
	$(DIR_O)\ScintillaBaseL.obj

$(DIR_O)\ScintRes.res : ScintRes.rc
	$(RC) -fo$@ $**

$(COMPONENT): $(SOBJS) $(DIR_O)\ScintRes.res
	$(LD) $(LDFLAGS) -DEF:Scintilla.def -DLL -OUT:$@ $** $(LIBS)

$(LEXCOMPONENT): $(SCILEXOBJS) $(DIR_O)\ScintillaWinL.obj $(DIR_O)\ScintRes.res
	$(LD) $(LDFLAGS) -DEF:Scintilla.def -DLL -OUT:$@ $** $(LIBS)

$(LIBSCI): $(SCILEXOBJS) $(DIR_O)\ScintillaWinS.obj
	LIB /OUT:$@ $**

# Define how to build all the objects and what they depend on

{..\src}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<
{..\lexlib}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<
{..\lexers}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<
{.}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<

# Some source files are compiled into more than one object because of different conditional compilation
$(DIR_O)\ScintillaBaseL.obj: ..\src\ScintillaBase.cxx
	$(CXX) $(CXXFLAGS) -DSCI_LEXER -c $(NAME)$@ ..\src\ScintillaBase.cxx

$(DIR_O)\ScintillaWinL.obj: ScintillaWin.cxx
	$(CXX) $(CXXFLAGS) -DSCI_LEXER -c $(NAME)$@ ScintillaWin.cxx

$(DIR_O)\ScintillaWinS.obj: ScintillaWin.cxx
	$(CXX) $(CXXFLAGS) -DSTATIC_BUILD -c $(NAME)$@ ScintillaWin.cxx

# Dependencies

# All lexers depend on this set of headers
LEX_HEADERS= \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/StyleContext.h \
	../lexlib/CharacterSet.h \
	../lexlib/LexerModule.h \
	../lexlib/OptionSet.h \
	../lexlib/SparseState.h \
	../lexlib/SubStyles.h

$(DIR_O)\Accessor.obj: \
	../lexlib/Accessor.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h
$(DIR_O)\AutoComplete.obj: \
	../src/AutoComplete.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../lexlib/CharacterSet.h \
	../src/Position.h \
	../src/AutoComplete.h
$(DIR_O)\CallTip.obj: \
	../src/CallTip.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/CallTip.h
$(DIR_O)\CaseConvert.obj: \
	../src/CaseConvert.cxx \
	../lexlib/StringCopy.h \
	../src/CaseConvert.h \
	../src/UniConversion.h
$(DIR_O)\CaseFolder.obj: \
	../src/CaseFolder.cxx \
	../src/CaseFolder.h \
	../src/CaseConvert.h
$(DIR_O)\Catalogue.obj: \
	../src/Catalogue.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/LexerModule.h \
	../src/Catalogue.h
$(DIR_O)\CellBuffer.obj: \
	../src/CellBuffer.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/CellBuffer.h \
	../src/UniConversion.h
$(DIR_O)\CharacterCategory.obj: \
	../lexlib/CharacterCategory.cxx \
	../lexlib/StringCopy.h \
	../lexlib/CharacterCategory.h
$(DIR_O)\CharacterSet.obj: \
	../lexlib/CharacterSet.cxx \
	../lexlib/CharacterSet.h
$(DIR_O)\CharClassify.obj: \
	../src/CharClassify.cxx \
	../src/CharClassify.h
$(DIR_O)\CheckD2D.obj: \
	CheckD2D.cxx
$(DIR_O)\ContractionState.obj: \
	../src/ContractionState.cxx \
	../include/Platform.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/SparseVector.h \
	../src/ContractionState.h
$(DIR_O)\DBCS.obj: \
	../src/DBCS.cxx \
	../src/DBCS.h
$(DIR_O)\Decoration.obj: \
	../src/Decoration.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/Decoration.h
$(DIR_O)\DefaultLexer.obj: \
	../lexlib/DefaultLexer.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/LexerModule.h \
	../lexlib/DefaultLexer.h
$(DIR_O)\Document.obj: \
	../src/Document.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/CharacterSet.h \
	../lexlib/CharacterCategory.h \
	../src/Position.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/CellBuffer.h \
	../src/PerLine.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/RESearch.h \
	../src/UniConversion.h
$(DIR_O)\EditModel.obj: \
	../src/EditModel.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h
$(DIR_O)\Editor.obj: \
	../src/Editor.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/PerLine.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h
$(DIR_O)\EditView.obj: \
	../src/EditView.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../lexlib/CharacterSet.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/PerLine.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h
$(DIR_O)\ExternalLexer.obj: \
	../src/ExternalLexer.cxx \
	../include/Platform.h \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/LexerModule.h \
	../src/Catalogue.h \
	../src/ExternalLexer.h
$(DIR_O)\HanjaDic.obj: \
	HanjaDic.cxx \
	../src/UniConversion.h \
	HanjaDic.h
$(DIR_O)\Indicator.obj: \
	../src/Indicator.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Indicator.h \
	../src/XPM.h
$(DIR_O)\KeyMap.obj: \
	../src/KeyMap.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/KeyMap.h

#++Autogenerated -- run scripts/LexGen.py to regenerate
#**\n\($(DIR_O)\\\*.obj: ..\\lexers\\\*.cxx $(LEX_HEADERS)\n\n\)

$(DIR_O)\LexA68k.obj: ..\lexers\LexA68k.cxx $(LEX_HEADERS)

$(DIR_O)\LexAbaqus.obj: ..\lexers\LexAbaqus.cxx $(LEX_HEADERS)

$(DIR_O)\LexAda.obj: ..\lexers\LexAda.cxx $(LEX_HEADERS)

$(DIR_O)\LexAPDL.obj: ..\lexers\LexAPDL.cxx $(LEX_HEADERS)

$(DIR_O)\LexAsm.obj: ..\lexers\LexAsm.cxx $(LEX_HEADERS)

$(DIR_O)\LexAsn1.obj: ..\lexers\LexAsn1.cxx $(LEX_HEADERS)

$(DIR_O)\LexASY.obj: ..\lexers\LexASY.cxx $(LEX_HEADERS)

$(DIR_O)\LexAU3.obj: ..\lexers\LexAU3.cxx $(LEX_HEADERS)

$(DIR_O)\LexAVE.obj: ..\lexers\LexAVE.cxx $(LEX_HEADERS)

$(DIR_O)\LexAVS.obj: ..\lexers\LexAVS.cxx $(LEX_HEADERS)

$(DIR_O)\LexBaan.obj: ..\lexers\LexBaan.cxx $(LEX_HEADERS)

$(DIR_O)\LexBash.obj: ..\lexers\LexBash.cxx $(LEX_HEADERS)

$(DIR_O)\LexBasic.obj: ..\lexers\LexBasic.cxx $(LEX_HEADERS)

$(DIR_O)\LexBatch.obj: ..\lexers\LexBatch.cxx $(LEX_HEADERS)

$(DIR_O)\LexBibTeX.obj: ..\lexers\LexBibTeX.cxx $(LEX_HEADERS)

$(DIR_O)\LexBullant.obj: ..\lexers\LexBullant.cxx $(LEX_HEADERS)

$(DIR_O)\LexCaml.obj: ..\lexers\LexCaml.cxx $(LEX_HEADERS)

$(DIR_O)\LexCLW.obj: ..\lexers\LexCLW.cxx $(LEX_HEADERS)

$(DIR_O)\LexCmake.obj: ..\lexers\LexCmake.cxx $(LEX_HEADERS)

$(DIR_O)\LexCOBOL.obj: ..\lexers\LexCOBOL.cxx $(LEX_HEADERS)

$(DIR_O)\LexCoffeeScript.obj: ..\lexers\LexCoffeeScript.cxx $(LEX_HEADERS)

$(DIR_O)\LexConf.obj: ..\lexers\LexConf.cxx $(LEX_HEADERS)

$(DIR_O)\LexCPP.obj: ..\lexers\LexCPP.cxx $(LEX_HEADERS)

$(DIR_O)\LexCrontab.obj: ..\lexers\LexCrontab.cxx $(LEX_HEADERS)

$(DIR_O)\LexCsound.obj: ..\lexers\LexCsound.cxx $(LEX_HEADERS)

$(DIR_O)\LexCSS.obj: ..\lexers\LexCSS.cxx $(LEX_HEADERS)

$(DIR_O)\LexD.obj: ..\lexers\LexD.cxx $(LEX_HEADERS)

$(DIR_O)\LexDiff.obj: ..\lexers\LexDiff.cxx $(LEX_HEADERS)

$(DIR_O)\LexDMAP.obj: ..\lexers\LexDMAP.cxx $(LEX_HEADERS)

$(DIR_O)\LexDMIS.obj: ..\lexers\LexDMIS.cxx $(LEX_HEADERS)

$(DIR_O)\LexECL.obj: ..\lexers\LexECL.cxx $(LEX_HEADERS)

$(DIR_O)\LexEDIFACT.obj: ..\lexers\LexEDIFACT.cxx $(LEX_HEADERS)

$(DIR_O)\LexEiffel.obj: ..\lexers\LexEiffel.cxx $(LEX_HEADERS)

$(DIR_O)\LexErlang.obj: ..\lexers\LexErlang.cxx $(LEX_HEADERS)

$(DIR_O)\LexErrorList.obj: ..\lexers\LexErrorList.cxx $(LEX_HEADERS)

$(DIR_O)\LexEScript.obj: ..\lexers\LexEScript.cxx $(LEX_HEADERS)

$(DIR_O)\LexFlagship.obj: ..\lexers\LexFlagship.cxx $(LEX_HEADERS)

$(DIR_O)\LexForth.obj: ..\lexers\LexForth.cxx $(LEX_HEADERS)

$(DIR_O)\LexFortran.obj: ..\lexers\LexFortran.cxx $(LEX_HEADERS)

$(DIR_O)\LexGAP.obj: ..\lexers\LexGAP.cxx $(LEX_HEADERS)

$(DIR_O)\LexGui4Cli.obj: ..\lexers\LexGui4Cli.cxx $(LEX_HEADERS)

$(DIR_O)\LexHaskell.obj: ..\lexers\LexHaskell.cxx $(LEX_HEADERS)

$(DIR_O)\LexHex.obj: ..\lexers\LexHex.cxx $(LEX_HEADERS)

$(DIR_O)\LexHTML.obj: ..\lexers\LexHTML.cxx $(LEX_HEADERS)

$(DIR_O)\LexIndent.obj: ..\lexers\LexIndent.cxx $(LEX_HEADERS)

$(DIR_O)\LexInno.obj: ..\lexers\LexInno.cxx $(LEX_HEADERS)

$(DIR_O)\LexJSON.obj: ..\lexers\LexJSON.cxx $(LEX_HEADERS)

$(DIR_O)\LexKix.obj: ..\lexers\LexKix.cxx $(LEX_HEADERS)

$(DIR_O)\LexKVIrc.obj: ..\lexers\LexKVIrc.cxx $(LEX_HEADERS)

$(DIR_O)\LexLaTeX.obj: ..\lexers\LexLaTeX.cxx $(LEX_HEADERS)

$(DIR_O)\LexLisp.obj: ..\lexers\LexLisp.cxx $(LEX_HEADERS)

$(DIR_O)\LexLout.obj: ..\lexers\LexLout.cxx $(LEX_HEADERS)

$(DIR_O)\LexLPeg.obj: ..\lexers\LexLPeg.cxx $(LEX_HEADERS)

$(DIR_O)\LexLua.obj: ..\lexers\LexLua.cxx $(LEX_HEADERS)

$(DIR_O)\LexMagik.obj: ..\lexers\LexMagik.cxx $(LEX_HEADERS)

$(DIR_O)\LexMake.obj: ..\lexers\LexMake.cxx $(LEX_HEADERS)

$(DIR_O)\LexMarkdown.obj: ..\lexers\LexMarkdown.cxx $(LEX_HEADERS)

$(DIR_O)\LexMatlab.obj: ..\lexers\LexMatlab.cxx $(LEX_HEADERS)

$(DIR_O)\LexMaxima.obj: ..\lexers\LexMaxima.cxx $(LEX_HEADERS)

$(DIR_O)\LexMetapost.obj: ..\lexers\LexMetapost.cxx $(LEX_HEADERS)

$(DIR_O)\LexMMIXAL.obj: ..\lexers\LexMMIXAL.cxx $(LEX_HEADERS)

$(DIR_O)\LexModula.obj: ..\lexers\LexModula.cxx $(LEX_HEADERS)

$(DIR_O)\LexMPT.obj: ..\lexers\LexMPT.cxx $(LEX_HEADERS)

$(DIR_O)\LexMSSQL.obj: ..\lexers\LexMSSQL.cxx $(LEX_HEADERS)

$(DIR_O)\LexMySQL.obj: ..\lexers\LexMySQL.cxx $(LEX_HEADERS)

$(DIR_O)\LexNimrod.obj: ..\lexers\LexNimrod.cxx $(LEX_HEADERS)

$(DIR_O)\LexNsis.obj: ..\lexers\LexNsis.cxx $(LEX_HEADERS)

$(DIR_O)\LexNull.obj: ..\lexers\LexNull.cxx $(LEX_HEADERS)

$(DIR_O)\LexOpal.obj: ..\lexers\LexOpal.cxx $(LEX_HEADERS)

$(DIR_O)\LexOScript.obj: ..\lexers\LexOScript.cxx $(LEX_HEADERS)

$(DIR_O)\LexPascal.obj: ..\lexers\LexPascal.cxx $(LEX_HEADERS)

$(DIR_O)\LexPB.obj: ..\lexers\LexPB.cxx $(LEX_HEADERS)

$(DIR_O)\LexPerl.obj: ..\lexers\LexPerl.cxx $(LEX_HEADERS)

$(DIR_O)\LexPLM.obj: ..\lexers\LexPLM.cxx $(LEX_HEADERS)

$(DIR_O)\LexPO.obj: ..\lexers\LexPO.cxx $(LEX_HEADERS)

$(DIR_O)\LexPOV.obj: ..\lexers\LexPOV.cxx $(LEX_HEADERS)

$(DIR_O)\LexPowerPro.obj: ..\lexers\LexPowerPro.cxx $(LEX_HEADERS)

$(DIR_O)\LexPowerShell.obj: ..\lexers\LexPowerShell.cxx $(LEX_HEADERS)

$(DIR_O)\LexProgress.obj: ..\lexers\LexProgress.cxx $(LEX_HEADERS)

$(DIR_O)\LexProps.obj: ..\lexers\LexProps.cxx $(LEX_HEADERS)

$(DIR_O)\LexPS.obj: ..\lexers\LexPS.cxx $(LEX_HEADERS)

$(DIR_O)\LexPython.obj: ..\lexers\LexPython.cxx $(LEX_HEADERS)

$(DIR_O)\LexR.obj: ..\lexers\LexR.cxx $(LEX_HEADERS)

$(DIR_O)\LexRebol.obj: ..\lexers\LexRebol.cxx $(LEX_HEADERS)

$(DIR_O)\LexRegistry.obj: ..\lexers\LexRegistry.cxx $(LEX_HEADERS)

$(DIR_O)\LexRuby.obj: ..\lexers\LexRuby.cxx $(LEX_HEADERS)

$(DIR_O)\LexRust.obj: ..\lexers\LexRust.cxx $(LEX_HEADERS)

$(DIR_O)\LexScriptol.obj: ..\lexers\LexScriptol.cxx $(LEX_HEADERS)

$(DIR_O)\LexSmalltalk.obj: ..\lexers\LexSmalltalk.cxx $(LEX_HEADERS)

$(DIR_O)\LexSML.obj: ..\lexers\LexSML.cxx $(LEX_HEADERS)

$(DIR_O)\LexSorcus.obj: ..\lexers\LexSorcus.cxx $(LEX_HEADERS)

$(DIR_O)\LexSpecman.obj: ..\lexers\LexSpecman.cxx $(LEX_HEADERS)

$(DIR_O)\LexSpice.obj: ..\lexers\LexSpice.cxx $(LEX_HEADERS)

$(DIR_O)\LexSQL.obj: ..\lexers\LexSQL.cxx $(LEX_HEADERS)

$(DIR_O)\LexSTTXT.obj: ..\lexers\LexSTTXT.cxx $(LEX_HEADERS)

$(DIR_O)\LexTACL.obj: ..\lexers\LexTACL.cxx $(LEX_HEADERS)

$(DIR_O)\LexTADS3.obj: ..\lexers\LexTADS3.cxx $(LEX_HEADERS)

$(DIR_O)\LexTAL.obj: ..\lexers\LexTAL.cxx $(LEX_HEADERS)

$(DIR_O)\LexTCL.obj: ..\lexers\LexTCL.cxx $(LEX_HEADERS)

$(DIR_O)\LexTCMD.obj: ..\lexers\LexTCMD.cxx $(LEX_HEADERS)

$(DIR_O)\LexTeX.obj: ..\lexers\LexTeX.cxx $(LEX_HEADERS)

$(DIR_O)\LexTxt2tags.obj: ..\lexers\LexTxt2tags.cxx $(LEX_HEADERS)

$(DIR_O)\LexVB.obj: ..\lexers\LexVB.cxx $(LEX_HEADERS)

$(DIR_O)\LexVerilog.obj: ..\lexers\LexVerilog.cxx $(LEX_HEADERS)

$(DIR_O)\LexVHDL.obj: ..\lexers\LexVHDL.cxx $(LEX_HEADERS)

$(DIR_O)\LexVisualProlog.obj: ..\lexers\LexVisualProlog.cxx $(LEX_HEADERS)

$(DIR_O)\LexYAML.obj: ..\lexers\LexYAML.cxx $(LEX_HEADERS)


#--Autogenerated -- end of automatically generated section

$(DIR_O)\LexerBase.obj: \
	../lexlib/LexerBase.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/LexerModule.h \
	../lexlib/LexerBase.h
$(DIR_O)\LexerModule.obj: \
	../lexlib/LexerModule.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/LexerModule.h \
	../lexlib/LexerBase.h \
	../lexlib/LexerSimple.h
$(DIR_O)\LexerNoExceptions.obj: \
	../lexlib/LexerNoExceptions.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/LexerModule.h \
	../lexlib/LexerBase.h \
	../lexlib/LexerNoExceptions.h
$(DIR_O)\LexerSimple.obj: \
	../lexlib/LexerSimple.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../include/Scintilla.h \
	../include/SciLexer.h \
	../lexlib/PropSetSimple.h \
	../lexlib/WordList.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/LexerModule.h \
	../lexlib/LexerBase.h \
	../lexlib/LexerSimple.h
$(DIR_O)\LineMarker.obj: \
	../src/LineMarker.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../lexlib/StringCopy.h \
	../src/XPM.h \
	../src/LineMarker.h
$(DIR_O)\MarginView.obj: \
	../src/MarginView.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h
$(DIR_O)\PerLine.obj: \
	../src/PerLine.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/CellBuffer.h \
	../src/PerLine.h
$(DIR_O)\PlatWin.obj: \
	PlatWin.cxx \
	../include/Platform.h \
	../lexlib/StringCopy.h \
	../src/XPM.h \
	../src/UniConversion.h \
	../src/DBCS.h \
	../src/FontQuality.h
$(DIR_O)\PositionCache.obj: \
	../src/PositionCache.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h
$(DIR_O)\PropSetSimple.obj: \
	../lexlib/PropSetSimple.cxx \
	../lexlib/PropSetSimple.h
$(DIR_O)\RESearch.obj: \
	../src/RESearch.cxx \
	../src/Position.h \
	../src/CharClassify.h \
	../src/RESearch.h
$(DIR_O)\RunStyles.obj: \
	../src/RunStyles.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h
$(DIR_O)\ScintillaBase.obj: \
	../src/ScintillaBase.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/PropSetSimple.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/CallTip.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h \
	../src/AutoComplete.h \
	../src/ScintillaBase.h
$(DIR_O)\ScintillaBaseL.obj: \
	../src/ScintillaBase.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/PropSetSimple.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/CallTip.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h \
	../src/AutoComplete.h \
	../src/ScintillaBase.h
$(DIR_O)\ScintillaWin.obj: \
	ScintillaWin.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/CallTip.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/CaseConvert.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h \
	../src/AutoComplete.h \
	../src/ScintillaBase.h \
	PlatWin.h \
	HanjaDic.h
$(DIR_O)\ScintillaWinL.obj: \
	ScintillaWin.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/CallTip.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/CaseConvert.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h \
	../src/AutoComplete.h \
	../src/ScintillaBase.h \
	PlatWin.h \
	HanjaDic.h
$(DIR_O)\ScintillaWinS.obj: \
	ScintillaWin.cxx \
	../include/Platform.h \
	../include/ILoader.h \
	../include/Sci_Position.h \
	../include/ILexer.h \
	../include/Scintilla.h \
	../lexlib/StringCopy.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/SplitVector.h \
	../src/Partitioning.h \
	../src/RunStyles.h \
	../src/ContractionState.h \
	../src/CellBuffer.h \
	../src/CallTip.h \
	../src/KeyMap.h \
	../src/Indicator.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h \
	../src/CharClassify.h \
	../src/Decoration.h \
	../src/CaseFolder.h \
	../src/Document.h \
	../src/CaseConvert.h \
	../src/UniConversion.h \
	../src/Selection.h \
	../src/PositionCache.h \
	../src/EditModel.h \
	../src/MarginView.h \
	../src/EditView.h \
	../src/Editor.h \
	../src/AutoComplete.h \
	../src/ScintillaBase.h \
	PlatWin.h \
	HanjaDic.h
$(DIR_O)\Selection.obj: \
	../src/Selection.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/Selection.h
$(DIR_O)\Style.obj: \
	../src/Style.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Style.h
$(DIR_O)\StyleContext.obj: \
	../lexlib/StyleContext.cxx \
	../include/ILexer.h \
	../include/Sci_Position.h \
	../lexlib/LexAccessor.h \
	../lexlib/Accessor.h \
	../lexlib/StyleContext.h \
	../lexlib/CharacterSet.h
$(DIR_O)\UniConversion.obj: \
	../src/UniConversion.cxx \
	../src/UniConversion.h
$(DIR_O)\ViewStyle.obj: \
	../src/ViewStyle.cxx \
	../include/Platform.h \
	../include/Scintilla.h \
	../include/Sci_Position.h \
	../src/Position.h \
	../src/UniqueString.h \
	../src/Indicator.h \
	../src/XPM.h \
	../src/LineMarker.h \
	../src/Style.h \
	../src/ViewStyle.h
$(DIR_O)\WordList.obj: \
	../lexlib/WordList.cxx \
	../lexlib/StringCopy.h \
	../lexlib/WordList.h
$(DIR_O)\XPM.obj: \
	../src/XPM.cxx \
	../include/Platform.h \
	../src/XPM.h
