import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Dropdown,
  Knob,
  LabeledControls,
  LabeledList,
  Section,
} from '../components';
import { Window } from '../layouts';

type JukeboxData = {
  active: BooleanLike;
  songs: Song[];
  track_author?: string;
  track_length?: number;
  track_selected?: string;
  volume: number;
};

type Song = {
  name: string;
};

export const Jukebox = (props) => {
  const { act, data } = useBackend<JukeboxData>();
  const { active, track_selected, track_length, track_author, volume } = data;
  const songs = data.songs.toSorted((a, b) => a.name.localeCompare(b.name));
  return (
    <Window width={370} height={313}>
      <Window.Content>
        <Section
          title="Song Player"
          buttons={
            <Button
              icon={active ? 'pause' : 'play'}
              content={active ? 'Stop' : 'Play'}
              selected={active}
              onClick={() => act('toggle')}
            />
          }
        >
          <LabeledList>
            <LabeledList.Item label="Track Selected">
              <Dropdown
                overflowY="scroll"
                width="240px"
                options={songs.map((song) => song.name)}
                disabled={active}
                selected={track_selected || 'Select a Track'}
                onSelected={(value) =>
                  act('select_track', {
                    track: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Track Length">
              {track_selected ? track_length : 'No Track Selected'}
            </LabeledList.Item>
            <LabeledList.Item label="Author">
              {track_selected
                ? track_author
                  ? track_author
                  : 'Priapus Company Band'
                : 'No Track Selected'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Machine Settings">
          <LabeledControls justify="center">
            <LabeledControls.Item label="Volume">
              <Box position="relative">
                <Knob
                  size={3.2}
                  color={volume >= 25 ? 'red' : 'green'}
                  value={volume}
                  unit="%"
                  minValue={0}
                  maxValue={65}
                  step={1}
                  stepPixelSize={1}
                  disabled={active}
                  onDrag={(e, value) =>
                    act('set_volume', {
                      volume: value,
                    })
                  }
                />
                <Button
                  fluid
                  position="absolute"
                  top="-2px"
                  right="-22px"
                  color="transparent"
                  icon="fast-backward"
                  onClick={() =>
                    act('set_volume', {
                      volume: 'min',
                    })
                  }
                />
                <Button
                  fluid
                  position="absolute"
                  top="16px"
                  right="-22px"
                  color="transparent"
                  icon="fast-forward"
                  onClick={() =>
                    act('set_volume', {
                      volume: 'max',
                    })
                  }
                />
                <Button
                  fluid
                  position="absolute"
                  top="34px"
                  right="-22px"
                  color="transparent"
                  icon="undo"
                  onClick={() =>
                    act('set_volume', {
                      volume: 'reset',
                    })
                  }
                />
              </Box>
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
      </Window.Content>
    </Window>
  );
};
