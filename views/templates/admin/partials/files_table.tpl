{*
 * Copyright 2023 Profileo Group <contact@profileo.com> (https://www.profileo.com/fr/)
 *
 * For questions or comments about this software, contact Maxime Morel-Bailly <security@prestascan.com>
 * List of required attribution notices and acknowledgements for third-party software can be found in the NOTICE file.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author    Profileo Group - Complete list of authors and contributors to this software can be found in the AUTHORS file.
 * @copyright Since 2023 Profileo Group <contact@profileo.com> (https://www.profileo.com/fr/)
 * @license   https://www.apache.org/licenses/LICENSE-2.0 Apache License, Version 2.0
 *}

{if $aFileType == 'noStandardFiles' || $aFileType == 'addedOrModifyFiles'}
    <table id="noStandardFiles" class="prestascansecurity_datatable sort-by-file-size" data-copy-title="" data-copy-messagetop="">
        <thead>
            <tr>
                <th width="60%">{l s='File path' mod='prestascansecurity'}</th>
                <th width="20%">{l s='Size' mod='prestascansecurity'}</th>
                <th width="20%">{l s='Modification date' mod='prestascansecurity'}</th>
            </tr>
        </thead>
        {foreach name=aFiles from=$aFiles item=aFile}
            <tr>
                <td width="60%" data-filepath="{$aFile.path}"><span class="filepath">{$aFile.path}<span class="tooltipPath">{$aFile.tooltip}</span></span></td>
                <td width="20%">{$aFile.filesize}</td>
                <td width="20%">{$aFile.modification_time}</td>
            </tr>
        {/foreach}
    </table>
{elseif $aFileType == 'DirectoriesProtection'}
    <table id="protectionFiles" class="prestascansecurity_datatable no-sort-by-file-size" data-copy-title="" data-copy-messagetop="">
        <thead>
            <tr>
                <th width="60%">{l s='Test URL' mod='prestascansecurity'}</th>
                <th width="20%">{l s='Result' mod='prestascansecurity'}</th>
                <th width="20%">{l s='Action' mod='prestascansecurity'}</th>
            </tr>
        </thead>
        {foreach name=aFiles from=$aFiles item=aFile}
            <tr>
                <td width="60%"><a href="{$aFile[0].directory}" target="_blank">{$aFile[0].directory}</a></td>
                <td width="20%" style="color:{if $aFile[0].status == 'fail' || $aFile[0].status == 'fail_curl'}#F45454{else}#3AD29F{/if}"><b>{if $aFile[0].status == 'fail'}{l s='Fail' mod='prestascansecurity'}{elseif $aFile[0].status == 'fail_curl'}{l s='Error' mod='prestascansecurity'}{else}{l s='Pass' mod='prestascansecurity'}{/if}</b></td>
                <td width="20%">
                    {if $aFile[0].status == 'fail'}
                        <a href="https://www.prestascan.com/fr/contactez-nous" target="_blank" class="eoaction btntooltip">{l s='Solve' mod='prestascansecurity'}<span class="tooltiptext">{$file_action}</span></a>
                    {/if}
                    {if $aFile[0].status == 'fail_curl'}
                        <div class="eoaction text-center">{l s='Error : Directory couldn\'t be scanned' mod='prestascansecurity'}</div>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>
{elseif $aFileType == 'infectedFiles'}
    <table id="{$id}" class="prestascansecurity_datatable no-sort-by-file-size" data-copy-title="" data-copy-messagetop="">
        <thead>
            <tr>
                <th width="30%">{l s='Path' mod='prestascansecurity'}</th>
                <th width="15%">{l s='Modified date' mod='prestascansecurity'}</th>
                <th width="10%">{l s='Status' mod='prestascansecurity'}</th>
                <th width="30%">{l s='Description' mod='prestascansecurity'}</th>
                <th width="15%">{l s='Action' mod='prestascansecurity'}</th>
            </tr>
        </thead>
        {foreach name=aFiles from=$aFiles item=aFile}
            <tr>
                <td width="30%" data-filepath="{$aFile.path}">{$aFile.path}</td>                
                <td width="15%">{$aFile.date_update}</td>
                <td width="10%" style="color:{if $aFile.result=='Infected'}#F45454{else}#3AD29F{/if}"><b>{if $aFile.result=='Infected'}{l s='Infected' mod='prestascansecurity'}{else}{l s='Pass' mod='prestascansecurity'}{/if}</b></td>
                <td width="30%">{$aFile.description}</td>
                <td width="15%">{if !empty($aFile.action)}<div class="eoaction btntooltip">{l s='Solve' mod='prestascansecurity'}<span class="tooltiptext">{$aFile.action}</span></div>{/if}</td>
            </tr>
        {/foreach}
    </table>
{elseif $aFileType == 'corevulnerabilities'}
    <table id="{$id}" class="prestascansecurity_datatable" data-copy-title="" data-copy-messagetop="">
        <thead>
            <tr>
                <th width="5%"></th>
                <th width="20%">{l s='CVE' mod='prestascansecurity'}</th>
                <th width="10%">{l s='Severity' mod='prestascansecurity'}</th>
                <th width="10%">{l s='FO' mod='prestascansecurity'}</th>
                <th width="10%">{l s='BO' mod='prestascansecurity'}</th>
                <th width="10%">{l s='From' mod='prestascansecurity'}</th>
                <th width="10%">{l s='To' mod='prestascansecurity'}</th>
                <th width="15%">{l s='Type' mod='prestascansecurity'}</th>
                <th width="10%"></th>
            </tr>
        </thead>
        {foreach name=aFiles from=$aFiles item=aFile}
            {if isset($aFile.severity.value) && ($aFile.severity.value === 'Critical' || $aFile.severity.value === 'critical')}
                {assign var='datasort' value=1}
            {elseif isset($aFile.severity.value) && ($aFile.severity.value === 'High' || $aFile.severity.value === 'high')}
                {assign var='datasort' value=2}
            {elseif isset($aFile.severity.value) && ($aFile.severity.value === 'Medium' || $aFile.severity.value === 'medium')}
                {assign var='datasort' value=3}
            {else}
                {assign var='datasort' value=4}
            {/if}

            {assign var='defaultLanguage' value=Context::getContext()->language->iso_code}
            {assign var='aFileDescription' value=$aFile.description.en.value}
            {if $defaultLanguage != 'en' && isset($aFile.description.{$defaultLanguage}.value) && !empty($aFile.description.{$defaultLanguage}.value)}
                {assign var='aFileDescription' value=$aFile.description.{$defaultLanguage}.value}
            {/if}
            <tr>
                <input type="hidden" class="description" name="description" value="{$aFileDescription|escape:'html'}"/>
                <td width="5%" class="dt-control"></td>  
                <td width="20%" class="cve"><strong>{$aFile.cve.value}</strong></td>
                <td width="10%" data-sort="{$datasort}">{$aFile.severity.value}</td>
                <td width="10%">{$aFile.fo.value}</td>
                <td width="10%">{$aFile.bo.value}</td>
                <td width="10%">{$aFile.from.value}</td>
                <td width="10%">{$aFile.to.value}</td>
                <td width="15%">{$aFile.type.value}</td>
                <td width="10%"><a class="eoaction" href="{$aFile.link}" target="_blank">{l s='Link' mod='prestascansecurity'}</a></td>
            </tr>
        {/foreach}
    </table>
{/if}