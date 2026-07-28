// ***************************************************************************
//
// MCP Server Library for DMVCFramework
//
// Copyright (c) 2010-2026 Daniele Teti
//
// https://github.com/danieleteti/delphimvcframework
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ***************************************************************************

unit MVCFramework.MCP.Attributes;

interface

{$SCOPEDENUMS ON}
type
  TMCPParamPresence = (Required, Optional);
{$SCOPEDENUMS OFF}

type
  { Marks a method as an MCP tool.
    ATitle/AReadOnlyHint/ADestructiveHint/AOpenWorldHint are optional MCP tool
    annotations (ref: https://modelcontextprotocol.io/specification/2025-03-26/server/tools).
    They are omitted from tools/list output unless explicitly provided, so
    existing 2-argument Create calls are unaffected. }
  MCPToolAttribute = class(TCustomAttribute)
  private
    FName: string;
    FDescription: string;
    FTitle: string;
    FReadOnlyHint: Boolean;
    FDestructiveHint: Boolean;
    FOpenWorldHint: Boolean;
  public
    constructor Create(const AName, ADescription: string;
      const ATitle: string = '';
      const AReadOnlyHint: Boolean = False;
      const ADestructiveHint: Boolean = False;
      const AOpenWorldHint: Boolean = False);
    property Name: string read FName;
    property Description: string read FDescription;
    property Title: string read FTitle;
    property ReadOnlyHint: Boolean read FReadOnlyHint;
    property DestructiveHint: Boolean read FDestructiveHint;
    property OpenWorldHint: Boolean read FOpenWorldHint;
  end;

  { Placed on a method parameter to provide its MCP description and required flag.
    Name and type are discovered automatically from the Delphi parameter itself. }
  MCPParamAttribute = class(TCustomAttribute)
  private
    FDescription: string;
    FRequired: Boolean;
  public
    constructor Create(const ADescription: string; ARequired: TMCPParamPresence = TMCPParamPresence.Required);
    property Description: string read FDescription;
    property Required: Boolean read FRequired;
  end;

  { Marks a method as an MCP resource }
  MCPResourceAttribute = class(TCustomAttribute)
  private
    FURI: string;
    FName: string;
    FDescription: string;
    FMimeType: string;
  public
    constructor Create(const AURI, AName, ADescription: string; const AMimeType: string = 'text/plain');
    property URI: string read FURI;
    property Name: string read FName;
    property Description: string read FDescription;
    property MimeType: string read FMimeType;
  end;

  { Marks a method as an MCP prompt }
  MCPPromptAttribute = class(TCustomAttribute)
  private
    FName: string;
    FDescription: string;
  public
    constructor Create(const AName, ADescription: string);
    property Name: string read FName;
    property Description: string read FDescription;
  end;

  { Describes an argument for an MCP prompt }
  MCPPromptArgAttribute = class(TCustomAttribute)
  private
    FName: string;
    FDescription: string;
    FRequired: Boolean;
  public
    constructor Create(const AName, ADescription: string; ARequired: TMCPParamPresence = TMCPParamPresence.Optional);
    property Name: string read FName;
    property Description: string read FDescription;
    property Required: Boolean read FRequired;
  end;

implementation

{ MCPToolAttribute }

constructor MCPToolAttribute.Create(const AName, ADescription: string;
  const ATitle: string; const AReadOnlyHint, ADestructiveHint, AOpenWorldHint: Boolean);
begin
  inherited Create;
  FName := AName;
  FDescription := ADescription;
  FTitle := ATitle;
  FReadOnlyHint := AReadOnlyHint;
  FDestructiveHint := ADestructiveHint;
  FOpenWorldHint := AOpenWorldHint;
end;

{ MCPParamAttribute }

constructor MCPParamAttribute.Create(const ADescription: string; ARequired: TMCPParamPresence);
begin
  inherited Create;
  FDescription := ADescription;
  FRequired := ARequired = TMCPParamPresence.Required;
end;

{ MCPResourceAttribute }

constructor MCPResourceAttribute.Create(const AURI, AName, ADescription: string; const AMimeType: string);
begin
  inherited Create;
  FURI := AURI;
  FName := AName;
  FDescription := ADescription;
  FMimeType := AMimeType;
end;

{ MCPPromptAttribute }

constructor MCPPromptAttribute.Create(const AName, ADescription: string);
begin
  inherited Create;
  FName := AName;
  FDescription := ADescription;
end;

{ MCPPromptArgAttribute }

constructor MCPPromptArgAttribute.Create(const AName, ADescription: string; ARequired: TMCPParamPresence);
begin
  inherited Create;
  FName := AName;
  FDescription := ADescription;
  FRequired := ARequired = TMCPParamPresence.Required;
end;

end.
